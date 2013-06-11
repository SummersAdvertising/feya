class OrdersController < ApplicationController
	before_filter :is_member, :only => [:check]
	def cart
		@order = Order.new		
	end
	def check
		@order = Order.new

		if(cookies[:cart])
			@cartItems = Array.new
			JSON.parse(cookies[:cart]).each do |item|
				@cartItems.push(item[1]["id"])
			end

			@cartItems = Product.find_all_by_id(@cartItems)

			@orderItems = Array.new
			@traceItems = Array.new

			@cartItems.each do |item|
				@item = JSON.parse(cookies[:cart])[item.id.to_s]

				#check stock
				# if(item.amount >= @item.amount)
				# end

				@orderItems.push({:id => item.id ,:name => item.name, :amount => @item["amount"], :price => item.price, :saleprice => item.saleprice})
			end
		end
	end
	def create
		exit
	end
end