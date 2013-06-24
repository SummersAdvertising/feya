# encoding: UTF-8
class Service::OrdersController < ApplicationController
	before_filter :is_member
	layout "service"

	def index
		@orders = current_member.orders
	end

	def show
		@order = current_member.orders.find(params[:id])
		@orderrefund = @order.orderrefunds.new

		rescue ActiveRecord::RecordNotFound
		@order = nil
	end

	def update
		@order = current_member.orders.find(params[:id])

		#order log
		@orderlog = Orderlog.new
        @orderlog.order_id = @order.id
        @orderlog.description = "通知已匯款。"
        @orderlog.save

		respond_to do |format|
			if ( @order.update_attributes(params[:order]) )
				format.html { redirect_to service_order_path(@order), notice: 'Order was successfully updated.' }
			else
				format.html { render "show" }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
	end

	def refund
		@order = current_member.orders.find(params[:id])
		@orderrefund = @order.orderrefunds.new(params[:orderrefund])
		@orderrefund.status = "未處理"

		respond_to do |format|
			if ( @orderrefund.save )
				#寄信
				Ordermailer.refund(current_member.email, @orderrefund).deliver
				format.html { redirect_to service_order_path(@order), notice: 'Order was successfully updated.' }
			else
				format.html { render "show" }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
		
	end
end