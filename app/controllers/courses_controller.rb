class CoursesController < ApplicationController

	before_filter :get_instruction
	
	def show
		@course = Course.find( params[ :id ] )
		
		@courses = @instruction.courses.where( "status = 'enable' AND id <> #{params[:id]}").sample(3)
		
	end
	
	private
		def get_instruction
			@instruction = Instruction.find( params[ :instruction_id ] )
			@instructions = Instruction.order('sort ASC, created_at ASC')
		end  
end