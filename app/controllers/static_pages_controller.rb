#encoding: utf-8
class StaticPagesController < ApplicationController
	def index
		@entries = Entry.limit(3)
		
		@products = Product.where( :status => '上架' ).limit(4)
		
	end
	
	def show
		pagename = params[ :pagename ]
		
		respond_to do | format | 
			format.html { render :template => 'static_pages/' + pagename }
		end
		
	end
	
end