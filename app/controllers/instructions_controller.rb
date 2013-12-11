class InstructionsController < ApplicationController
	def index
		redirect_to class_path( :id => 1 )
	end
	
	def show
		
	end
end
