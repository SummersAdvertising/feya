# encoding: UTF-8
class Cart::CartController < ApplicationController
	layout "order"
	before_filter :is_member, :only => [:check]
	
	def show
		if(cookies[:cart] && cookies[:cart].length > 0)
			@checkItems = JSON.parse(cookies[:cart])

			@checkResult = checkItem(@checkItems)

			@orderItems = @checkResult[0]
			@traceItems = @checkResult[1]
		end
	end

	def add
		#check stock
		@stock = Stock.find(params[:orderitem][:stock_id])
		
		if(@stock)
			if(!@stock.amount || @stock.amount >= params[:orderitem][:amount].to_i )
				#write cookie
				if(cookies[:cart])
					@cartitems = JSON.parse(cookies[:cart])
				else
					@cartitems = Hash.new
				end

				@cartitems[params[:orderitem][:stock_id]] = params[:orderitem][:amount]
				cookies[:cart] = @cartitems.to_json

				respond_to do |format|
					format.html { redirect_to :back, notice: "已新增至購物車。" }
				end
			
			else
				respond_to do |format|
					format.html { redirect_to :back, alert: "商品的庫存量不足。" }
				end
			end

		end
		
	end

	def plus
		@stock = Stock.find(params[:stock_id])
		@cartitems = JSON.parse(cookies[:cart])

		if(!@stock.amount || @cartitems[params[:stock_id].to_s].to_i < @stock.amount )
			
			@cartitems[params[:stock_id].to_s] = @cartitems[params[:stock_id].to_s].to_i + 1;

			cookies[:cart] = @cartitems.to_json

			respond_to do |format|
				format.html { redirect_to root_cart_orders_path }
			end
		else
			respond_to do |format|
				format.html { redirect_to root_cart_orders_path, alert: "訂購數量到達庫存上限。" }
			end
		end
		
	end

	def minus
		@cartitems = JSON.parse(cookies[:cart])

		if(@cartitems[params[:stock_id].to_s].to_i > 1)
			@cartitems[params[:stock_id].to_s] = @cartitems[params[:stock_id].to_s].to_i - 1;
			
			cookies[:cart] = @cartitems.to_json
		end

		respond_to do |format|
			format.html { redirect_to root_cart_orders_path }
		end
	end

	def delete
		@cartitems = JSON.parse(cookies[:cart])
		@cartitems.delete(params[:stock_id].to_s);

		cookies[:cart] = @cartitems.to_json

		respond_to do |format|
			format.html { redirect_to root_cart_orders_path }
		end
		
	end
	
	def checkItem(checkItems)
		@orderItems = Array.new
		@traceItems = Array.new

		@items = Stock.where(:id => checkItems.keys ).select("stocks.*, products.name, products.price, products.saleprice, products.cover").joins('LEFT OUTER JOIN products on products.id = stocks.product_id')
		@items.each do |stockItem|
			if(stockItem.amount)
				if(stockItem.amount > checkItems[stockItem.id.to_s].to_i)
					@orderItems.push({:id => stockItem.id ,:name => stockItem.name, :typename => stockItem.typename == "default" ? "未指定" : stockItem.typename, :image => stockItem.cover, :amount => checkItems[stockItem.id.to_s],:price => stockItem.price, :saleprice => stockItem.saleprice})
				elsif(stockItem.amount > 0)
					@orderItems.push({:id => stockItem.id,:name => stockItem.name, :typename =>  stockItem.typename == "default" ? "未指定" : stockItem.typename, :image => stockItem.cover, :amount => stockItem.amount,:price => stockItem.price, :saleprice => stockItem.saleprice})
				else
					@traceItems.push(stockItem.id)
				end
			else
				@orderItems.push({:id => stockItem.id,:name => stockItem.name, :typename =>  stockItem.typename == "default" ? "未指定" : stockItem.typename, :image => stockItem.cover, :amount => checkItems[stockItem.id.to_s],:price => stockItem.price, :saleprice => stockItem.saleprice})
			end
		end

		return [@orderItems, @traceItems]
	end
end