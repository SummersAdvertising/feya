# encoding: UTF-8
class Cart::CartController < ApplicationController
	layout "order"
	before_filter :is_member, :only => [:check]
	
	def show
		
	end

	def add
		if(cookies[:cart])
			@cartiems = JSON.parse(cookies[:cart]) 
		else
			@cartiems = Hash.new
		end

		@cartiems.merge({ "stock_id" => params[:orderitem][:stock_id], "amount" => params[:orderitem][:amount] })
		return render :text => @cartiems.to_s
		cookies[:cart] = @cartiems.to_json

		respond_to do |format|
			format.html { redirect_to :back }
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