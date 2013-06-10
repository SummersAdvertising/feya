class OrdersController < ApplicationController
	before_filter :is_member, :only => [:check]
	def cart
		@order = Order.new		
	end
	def check
		#first check do products exist and have stocks
	end
end