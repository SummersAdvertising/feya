class StaticPagesController < ApplicationController
	def index
	end
	
	def show
		pagename = params[ :pagename ]
		
		respond_to do | format | 
			format.html { render :template => 'static_pages/' + pagename }
		end
		
	end
	
end
