# encoding: utf-8
class Admin::CoursesController < AdminController
	
	before_filter :get_instruction
	
	def switch
		@course = Course.find(params[:id])
		
		@course.update_attribute(:status, @course.status == 'disable' ? 'enable' : 'disable' )
		
		redirect_to admin_instruction_path( @instruction, :page => params[ :page ] )
		
		
	end
	
  # GET /admin/courses/1
  # GET /admin/courses/1.json
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /admin/courses/new
  # GET /admin/courses/new.json
  def create
    @course = @instruction.courses.build(params[:admin_course])
    @course.article = Article.new
    @course.name = '未命名課程'
    @course.price = 0
    @course.quota = 0
    
    respond_to do |format|
      if @course.save!
        format.html { redirect_to edit_admin_instruction_course_path(@instruction, @course), notice: '成功建立課程' }
        format.json { render json: @course, status: :created, location: @course }
        
      else
      	flash[ :warning ] = @course.errors.messages.values.flatten.join('<br>')
      	
      	
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /admin/courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # PUT /admin/courses/1
  # PUT /admin/courses/1.json
  def update
    @course = Course.find(params[:id])
    
    respond_to do |format|
      if @course.update_attributes(params[:course]) && ( params[ :course ][ :article ].nil? ^ @course.article.update_attributes( params[ :course ][ :article ] ) )
      
        format.html { redirect_to admin_instruction_path( @instruction ), notice: '成功更新課程' }
        format.json { head :no_content }
      else
      
      	flash[ :warning ] = @course.errors.messages.values.flatten.join('<br>')
      	
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/courses/1
  # DELETE /admin/courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to admin_instruction_path( @instruction ), notice: '課程刪除完成' }
      format.json { head :no_content }
    end
  end
  
private
	def get_instruction
		@instruction = Instruction.find( params[ :instruction_id ] )
		@instructions = Instruction.order('sort ASC, created_at ASC').all
	end  
end

