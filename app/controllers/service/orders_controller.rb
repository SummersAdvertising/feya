class Service::OrdersController < ApplicationController
	before_filter :is_member
	layout "service"

	def index
		@orders = Order.where(["member_id = ?", current_member.id])
	end

	def show
		@order = Order.find(params[:id])
	end
end