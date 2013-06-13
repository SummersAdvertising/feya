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

		#if(params[:updateMemberinfo]) => update
		#if(params[:addAddressbook]) => create

		@checkItems = Hash.new
		JSON.parse(params[:orderItems]).each do |orderItem|
			@checkItems[orderItem["id"]] = orderItem["amount"]
		end

		@checkResult = checkItem(@checkItems)

		@orderItems = @checkResult[0]
		@traceItems = @checkResult[1]

		#count discountpoints

		if(@order.save)
			@orderItems.each do |orderItem|
				@orderItem = Orderitem.new
				@orderItem.order_id = @order.id
				@orderItem.product_id = orderItem[:id]
				@orderItem.amount = orderItem[:amount]
				@orderItem.itemprice = orderItem[:saleprice] ? orderItem[:saleprice] : orderItem[:price]
				if(@orderItem.save)
					#substract stock
				end
			end
			
			Ordermailer.new(current_member.email, @order).deliver

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

		@items = Product.find_all_by_id(checkItems.keys)
		@items.each do |stockItem|
			if(stockItem.amount)
				if(stockItem.amount > @checkItems[stockItem.id].to_i)
					@orderItems.push({:id => stockItem.id,:name => stockItem.name, :amount => checkItems[stockItem.id],:price => stockItem.price, :saleprice => stockItem.saleprice})
				elsif(stockItem.amount > 0)
					@orderItems.push({:id => stockItem.id,:name => stockItem.name, :amount => stockItem.amount,:price => stockItem.price, :saleprice => stockItem.saleprice})
				else
					@traceItems.push({:id => stockItem.id,:name => stockItem.name})
				end
			else
				@orderItems.push({:id => stockItem.id,:name => stockItem.name, :amount => checkItems[stockItem.id],:price => stockItem.price, :saleprice => stockItem.saleprice})
			end
		end

		return [@orderItems, @traceItems]
	end
end