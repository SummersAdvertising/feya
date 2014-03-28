# encoding: utf-8
class InquirementsController < ApplicationController

	before_filter :get_courses

  # GET /inquirements/new
  # GET /inquirements/new.json
  def new
    @inquirement = Inquirement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inquirement }
    end
  end
  # POST /inquirements
  # POST /inquirements.json
  def create
    @inquirement = @course.inquirements.build(params[:inquirement])
    
    @inquirement.course_name = @course.name
    @inquirement.instruction_name = @course.instruction.name
    
    respond_to do |format|
      if @inquirement.save
      	
      	InquirementMailer.delay.send_notice( @inquirement )
      
        format.html { redirect_to instruction_course_path( @instruction, @course ), notice: '已經收到您的詢問，將會有專業人員與您聯絡！' }
        format.json { render json: @inquirement, status: :created, location: @inquirement }
      else
      	flash[ :warning ] = '您的資料填寫有誤！'
        format.html { redirect_to instruction_course_path( @instruction, @course ) }
        format.json { render json: @inquirement.errors, status: :unprocessable_entity }
      end
    end
  end

private
	def get_courses
		@instruction = Instruction.find( params[ :instruction_id ] )
		@course = Course.find( params[ :course_id ] )
		
		
		
	end

end
