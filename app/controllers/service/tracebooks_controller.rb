class Service::TracebooksController < ApplicationController
	before_filter :is_member
	layout "service"

	def index
		@tracebooks = current_member.tracebooks
	end

	def show
		@order = current_member.orders.find(params[:id])
		rescue ActiveRecord::RecordNotFound
		@order = nil
	end
end