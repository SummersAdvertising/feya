class InstructionsController < ApplicationController
	def index
		@instruction = Instruction.first
	
		respond_to do | format |
			if @instruction.nil?
				params[ :dump ] = 'test'
				exit
				format.html { render 'layouts/empty' }
			else
				format.html { redirect_to instruction_path( @instruction ) }
			end
		end
	
		
	end
	
	def show
		
		@instructions = Instruction.order( 'sort ASC' )
		@instruction = Instruction.find( params[ :id ] )
		
		@courses = @instruction.courses.where(" status = 'enable'")
		
	end
end
