class CoursesController < ApplicationController

	before_filter :get_instruction
	
	def show
		@course = Course.find( params[ :id ] )
	end
	

	private
		def get_instruction
			@instruction = Instruction.find( params[ :instruction_id ] )
			@instructions = Instruction.order('sort ASC, created_at ASC').all
		end  

end
