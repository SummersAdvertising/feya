class Service::OrdersController < ApplicationController
	before_filter :is_member
	layout "service"

	def index
		@orders = current_member.orders
	end

	def show
		@order = current_member.orders.find(params[:id])
		rescue ActiveRecord::RecordNotFound
		@order = nil
	end
end