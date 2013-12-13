class TestimoniesController < ApplicationController
	def index
		
		@testimonies = Testimony.page( params[ :page ] ).per(5)
		
		@instructions = Instruction.order( :sort => :asc )
		
	end
end
