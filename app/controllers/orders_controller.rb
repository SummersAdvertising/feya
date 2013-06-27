# encoding: UTF-8
class OrdersController < ApplicationController
	layout "order"
	before_filter :is_member, :only => [:check]
	
	def cart
		@order = Order.new		
	end

	def check
		@order = Order.new

		if(cookies[:cart].length > 0)
			@checkItems = Hash.new

			JSON.parse(cookies[:cart]).each do |orderItem|
				@checkItems[orderItem[1]["id"].to_i] = orderItem[1]["amount"]
			end

			@checkResult = checkItem(@checkItems)

			@orderItems = @checkResult[0]
			@traceItems = @checkResult[1]
		end
	end

	def create
		@order = Order.new(params[:order])
		@order.member_id = current_member.id
		@order.status = "new"
		@order.ordernum = Date.today.strftime("%Y%m%d").to_s + ("%04d" % (Order.where("created_at >= ?", Time.zone.now.beginning_of_day).count + 1))

		case @order.paytype
		when "匯款"
			@order.shippingfee = 60
		when "貨到付款"
			@order.shippingfee = 150
		else
			@order.shippingfee = 0
		end			 	

		@checkItems = Hash.new
		JSON.parse(params[:orderItems]).each do |orderItem|
			@checkItems[orderItem["id"]] = orderItem["amount"]
		end

		@checkResult = checkItem(@checkItems)

		@orderItems = @checkResult[0]
		@traceItems = @checkResult[1]

		if(@order.save)

			#if(params[:updateMemberinfo]) => update
			if(params[:updateMemberinfo] || params[:setDefault])
				if(params[:updateMemberinfo])
					current_member.username = params[:order][:buyername]
					current_member.tel = params[:order][:buyertel]
				end
				if(params[:setDefault])
					current_member.receiveaddress = params[:order][:receiveraddress]
				end
				current_member.save
			end

			#if(params[:addAddressbook]) => create
			if(params[:addAddressbook])
				@addressbook = current_member.addressbooks.new
				@addressbook.address = params[:order][:receiveraddress]
				@addressbook.save
			end

			@runoutItems = Array.new
			@ordersum = 0

			@orderItems.each do |orderItem|
				@orderItem = Orderitem.new
				@orderItem.order_id = @order.id
				@orderItem.stock_id = orderItem[:id]
				@orderItem.amount = orderItem[:amount]
				@orderItem.itemprice = orderItem[:saleprice] ? orderItem[:saleprice] : orderItem[:price]

				if(@orderItem.save)
					#substract stock
					@stock = Stock.find(orderItem[:id])
					
					if(@stock.amount)
						@stock.amount = (@stock.amount.to_i - orderItem[:amount].to_i)
						@stock.save

						if(@stock.amount <= 0)
							@runoutItems.push(@stock.id)
						end
					end

					#calculate sum
					@ordersum = @ordersum + (@orderItem.amount.to_i * @orderItem.itemprice.to_i)

				end
			end

			if(@order.orderitems.count > 0)

				if(params[:discount] && (params[:discount].to_i.is_a? Integer)  && params[:discount].to_i > 0)
					if(params[:discount].to_i > current_member.discountpoint)
						if(current_member.discountpoint > (@ordersum/10).floor)
							@order.discount = (@ordersum/10).floor
						else
							@order.discount = current_member.discountpoint
						end
					else
						if(params[:discount].to_i > (@ordersum/10).floor)
							@order.discount = (@ordersum/10).floor
						else
							@order.discount = params[:discount].to_i
						end
					end
				else
					@order.discount = 0
				end

				#count discountpoints
				@order.discountpoint = (@ordersum / 200).floor
				current_member.discountpoint = current_member.discountpoint + @order.discountpoint - @order.discount

				if(@order.save)
					current_member.save
				end

				Ordermailer.new(current_member.email, @order).deliver
			else
				@order.delete
			end

			if(@runoutItems.length > 0)
				Ordermailer.runoutofproduct(@runoutItems).deliver
			end

			respond_to do |format|
				format.html { redirect_to finish_orders_path }
				format.json { render json: @order }
			end

		else

			respond_to do |format|
				format.html { render action: "check"}
				format.json { render json: @order }
			end
		end
	end

	def finish
		cookies[:cart] = nil
	end

	def checkItem(checkItems)
		@orderItems = Array.new
		@traceItems = Array.new

		@items = Stock.where(:id => checkItems.keys ).select("stocks.*, products.name, products.price, products.saleprice").joins('LEFT OUTER JOIN products on products.id = stocks.product_id')
		@items.each do |stockItem|
			if(stockItem.amount)
				if(stockItem.amount > @checkItems[stockItem.id].to_i)
					@orderItems.push({:id => stockItem.id ,:name => (stockItem.name+(("("+stockItem.typename+")") if stockItem.typename)), :amount => checkItems[stockItem.id],:price => stockItem.price, :saleprice => stockItem.saleprice})
				elsif(stockItem.amount > 0)
					@orderItems.push({:id => stockItem.id,:name => stockItem.name+(("("+stockItem.typename+")") if stockItem.typename), :amount => stockItem.amount,:price => stockItem.price, :saleprice => stockItem.saleprice})
				else
					@traceItems.push(stockItem.id)
				end
			else
				@orderItems.push({:id => stockItem.id,:name => stockItem.name+(("("+stockItem.typename+")") if stockItem.typename), :amount => checkItems[stockItem.id],:price => stockItem.price, :saleprice => stockItem.saleprice})
			end
		end

		return [@orderItems, @traceItems]
	end
end