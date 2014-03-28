# encoding: utf-8
class Admin::InstructionsController < AdminController

	before_filter :get_instructions, :only => [ :index, :show, :new, :edit ]

	def new
		@instruction = Instruction.new
	end
	
	def edit
		@instruction = Instruction.find( params[ :id ] )
	end

	def index
	
		respond_to do | format |
			if @instructions.first.nil?
				format.html { render :show }
			else
				format.html{ redirect_to admin_instruction_path @instructions.first }
			end
		end
		
	end
	
	def show
		
		@instruction = Instruction.find( params[ :id ] )
		
		@courses = @instruction.courses.page( params[ :page ] ).per( 20 )
		 
	end
	
	def update
		@instruction = Instruction.find( params[ :id ] )
		
		respond_to do |format|
	      if @instruction.update_attributes( params[ :instruction ] )
	        format.html { redirect_to admin_instruction_path(@instruction), notice: '成功更新課程分類' }
	        format.json { render json: @instruction, status: :created, location: @instruction }
	      else
	      	flash[ :warning ] = @instruction.errors.messages.values.flatten.join('<br>')
	      	get_instructions()
	        format.html { render action: "new" }
	        format.json { render json: @instruction.errors, status: :unprocessable_entity }
	      end
	    end
		
	end
	
	def create
		
	    @instruction = Instruction.new( params[ :instruction ] )

	    respond_to do |format|
	      if @instruction.save
	        format.html { redirect_to admin_instruction_path(@instruction), notice: '成功建立課程分類' }
	        format.json { render json: @instruction, status: :created, location: @instruction }
	      else
	      	flash[ :warning ] = @instruction.errors.messages.values.flatten.join('<br>')
	      	get_instructions()
	        format.html { render action: "new" }
	        format.json { render json: @instruction.errors, status: :unprocessable_entity }
	      end
	    end
	
	end
	
	def destroy
		@instruction = Instruction.find( params[ :id ] )
		@instruction.destroy
		
		respond_to do | format |
			format.html{ redirect_to admin_instructions_path, notice: '成功刪除課程分類'  }
		end
		
	end

private
	def get_instructions
		@instructions = Instruction.order('sort ASC, created_at ASC').all
		
	end


end
