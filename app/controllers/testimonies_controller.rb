class TestimoniesController < ApplicationController
	def index
		
		@instructions = Instruction.order( :sort => :asc )
		
		@instruction = Instruction.find( params[ :instruction_id ] )
		
		@testimonies = @instruction.testimonies.page( params[ :page ] ).per(5)
		
		
	end
end
