# encoding: UTF-8
class OrdersController < ApplicationController
	before_filter :is_member, :only => [:check]
	
	def cart
		@order = Order.new		
	end

	def check
		@order = Order.new

		if(cookies[:cart])
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

		#count discountpoints

		if(@order.save)

			#if(params[:updateMemberinfo]) => update
			if(params[:updateMemberinfo])
				current_member.username = params[:order][:buyername]
				current_member.tel = params[:order][:buyertel]
				current_member.save
			end

			#if(params[:addAddressbook]) => create
			if(params[:addAddressbook])
				@addressbook = Addressbook.new
				@addressbook.member_id = current_member.id
				@addressbook.address = params[:order][:receiveraddress]
				@addressbook.save
			end

			@runoutItems = Array.new

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

				end
			end
			
			Ordermailer.new(current_member.email, @order).deliver

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