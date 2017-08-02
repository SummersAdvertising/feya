# encoding: utf-8
class CoursesController < ApplicationController

	before_filter :get_instruction

	def show
		@course = Course.find( params[ :id ] )

		@inquirement = @course.inquirements.build

		@courses = @instruction.courses.where( "status = 'enable' AND id <> #{params[:id]}").sample(3)

		if params[:success] == "true"
			flash[:notice] = "已經收到您的詢問，將會有專業人員與您聯絡！"
		end
	end

	def link
		render :layout => false
	end

	def link_ask
		render :layout => false
	end

	private
		def get_instruction
			@instruction = Instruction.find( params[ :instruction_id ] )
			@instructions = Instruction.order('sort ASC, created_at ASC')
		end
end
