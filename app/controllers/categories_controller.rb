# encoding: utf-8
class CategoriesController < ApplicationController
	def index
		redirect_to category_path( :id => 1 )
	end
	
	def show
			
    @order = Order.new
    @products = Product.where(:status => "上架").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
		
	end
end
