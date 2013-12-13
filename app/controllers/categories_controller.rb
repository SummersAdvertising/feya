# encoding: utf-8
class CategoriesController < ApplicationController
	
	before_filter :get_categories
	
	def index
		redirect_to category_path( :id => 1 )
	end
	
	def show
		@category = Category.find( params[ :id ] )
			
	    @order = Order.new
	    @products = Product.where(:status => "上架").all
	
	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @products }
	    end
		
	end
	
private
	def get_categories
		@categories = Category.order( 'lft asc' )
	end	
	
end
