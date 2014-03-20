# encoding: UTF-8
class Service::OrdersController < ApplicationController
	before_filter :is_member
	layout "service"

	def index
		@orders = current_member.orders.order("created_at DESC").page(params[:page])
	end

	def show
		@orders = current_member.orders.order("created_at DESC").page(params[:page])
		@order = current_member.orders.find(params[:id])
		@orderrefund = @order.orderrefunds.new

		rescue ActiveRecord::RecordNotFound
		@order = nil
	end

	def update
		@order = current_member.orders.find(params[:id])

		if(params[:order][:payaccount].length>0 && params[:order][:paydate].length>0 && params[:order][:paytime].length>0)
			if(@order.update_attributes(params[:order]))
				#order log
				@orderlog = @order.orderlogs.new
				@orderlog.description = "通知已匯款。"
				
				@orderlog.save

				Ordermailer.delay.payment_notice( @order )

				respond_to do |format|
					format.html { redirect_to service_order_path(@order) }
				end
			else
				@orders = current_member.orders.order("created_at DESC").page(params[:page])
				@orderrefund = @order.orderrefunds.new
				@order.payaccount = nil
				respond_to do |format|
					format.html { render :action => :show   }
					format.json { render json: @order.errors, status: :unprocessable_entity }
				end
			end
		else
			respond_to do |format|
				format.html { redirect_to service_order_path(@order), alert: '請完整輸入匯款資訊。' }
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
				Ordermailer.delay.refund(current_member.email, @orderrefund)
				format.html { redirect_to service_order_path(@order), notice: '您的問題已送出，請等待客服人員與您聯繫。' }
			else
				@orders = current_member.orders.order("created_at DESC").page(params[:page])
				format.html { redirect_to service_order_path(@order), alert: '請輸入問題描述' }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
		
	end
end