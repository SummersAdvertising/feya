# encoding: utf-8
class Admin::TestimoniesController < AdminController

  before_filter :get_instructions, :only => [ :index, :show, :new, :edit ]

  # GET /admin/testimonies
  # GET /admin/testimonies.json
  def index
	@instruction = Instruction.find( params[ :instruction_id ] )
    @testimonies = @instruction.testimonies.page( params[ :page ] ).per(20)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @testimonies }
    end
  end
  
  # GET /admin/testimonies/new
  # GET /admin/testimonies/new.json
  def create
	@instruction = Instruction.find( params[ :instruction_id ] )
	
    @testimony = Testimony.new
    @testimony.article = Article.new
    @testimony.title = '未命名學員'

    respond_to do |format|
      if @testimony.save
        format.html { redirect_to edit_admin_instruction_testimony_path( @instruction, @testimony), notice: 'Testimony was successfully created.' }
        format.json { render json: @testimony, status: :created, location: @testimony }
      else
      
      	flash[ :warning ] = @testimony.errors.messages.values.flatten.join('<br>')
        format.html { render action: "index" }
        format.json { render json: @testimony.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /admin/testimonies/1/edit
  def edit
    @testimony = Testimony.find(params[:id])
	@instruction = @testimony.instruction.nil? ? Instruction.first : @testimony.instruction
	
  end

  # PUT /admin/testimonies/1
  # PUT /admin/testimonies/1.json
  def update
    @testimony = Testimony.find(params[:id])
	@instruction = Instruction.find( params[ :instruction_id ] )

    respond_to do |format|
      if @testimony.update_attributes(params[:testimony]) && ( params[ :article ].nil? ^ @testimony.article.update_attributes( params[ :article ] ) )
        format.html { redirect_to admin_instruction_testimonies_path( @testimony.instruction ), notice: 'Testimony was successfully updated.' }
        format.js { head :no_content }
      else
      
      	flash[ :warning ] = @testimony.errors.messages.values.flatten.join('<br>')
      	
        format.html { render action: "edit" }
        format.js { render json: @testimony.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/testimonies/1
  # DELETE /admin/testimonies/1.json
  def destroy
    @testimony = Testimony.find(params[:id])
    @testimony.destroy
    
	@instruction = Instruction.find( params[ :instruction_id ] )
    
    respond_to do |format|
      format.html { redirect_to admin_instruction_testimonies_path( @instruction ) }
      format.json { head :no_content }
    end
  end
  

private
	def get_instructions
		@instructions = Instruction.order('sort ASC, created_at ASC').all
	end
  
end
