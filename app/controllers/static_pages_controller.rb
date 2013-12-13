class StaticPagesController < ApplicationController
	def index
		@entries = Entry.limit(3)
	
	end
	
	def show
		pagename = params[ :pagename ]
		
		respond_to do | format | 
			format.html { render :template => 'static_pages/' + pagename }
		end
		
	end
	
end
