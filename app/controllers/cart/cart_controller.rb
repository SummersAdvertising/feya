# encoding: UTF-8
class Cart::CartController < ApplicationController
	layout "order"
	before_filter :is_member, :only => [:check]
	
	def show
		
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
				# return render :text => @cartitems.to_json
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
	
	def checkItem(checkItems)
		@orderItems = Array.new
		@traceItems = Array.new

		@items = Stock.where(:id => checkItems.keys ).select("stocks.*, products.name, products.price, products.saleprice, products.cover").joins('LEFT OUTER JOIN products on products.id = stocks.product_id')
		@items.each do |stockItem|
			if(stockItem.amount)
				if(stockItem.amount > @checkItems[stockItem.id].to_i)
					@orderItems.push({:id => stockItem.id ,:name => stockItem.name, :typename => stockItem.typename == "default" ? "未指定" : stockItem.typename, :image => stockItem.cover, :amount => checkItems[stockItem.id],:price => stockItem.price, :saleprice => stockItem.saleprice})
				elsif(stockItem.amount > 0)
					@orderItems.push({:id => stockItem.id,:name => stockItem.name, :typename =>  stockItem.typename == "default" ? "未指定" : stockItem.typename, :image => stockItem.cover, :amount => stockItem.amount,:price => stockItem.price, :saleprice => stockItem.saleprice})
				else
					@traceItems.push(stockItem.id)
				end
			else
				@orderItems.push({:id => stockItem.id,:name => stockItem.name, :typename =>  stockItem.typename == "default" ? "未指定" : stockItem.typename, :image => stockItem.cover, :amount => checkItems[stockItem.id],:price => stockItem.price, :saleprice => stockItem.saleprice})
			end
		end

		return [@orderItems, @traceItems]
	end
end