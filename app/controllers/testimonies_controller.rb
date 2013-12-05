class TestimoniesController < ApplicationController
	def index
		redirect_to testimony_path( :id => 1 )
	end
	
	def show
		
	end
end
