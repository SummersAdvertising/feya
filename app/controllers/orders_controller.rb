class OrdersController < ApplicationController
	before_filter :is_member, :only => [:check]
	def cart
		@order = Order.new		
	end
	def check
		#first check do products exist and have stocks
		@cartItems = Array.new
		JSON.parse(cookies[:cart]).each do |item|
			@cartItems.push(item[1]["id"])
		end

		@cartItems = Product.find_all_by_id(@cartItems)

		@orderItems = Array.new
		@traceItems = Array.new
		@cartItems.each do |item|
			#check stock
			@item = JSON.parse(cookies[:cart])[item.id.to_s]
			@orderItems.push({:name => item.name, :amount => @item["amount"]})
		end
	end
end