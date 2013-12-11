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
		 
	end
	
	def update
		@instruction = Instruction.find( params[ :id ] )
		
		respond_to do |format|
	      if @instruction.update_attributes( params[ :instruction ] )
	        format.html { redirect_to admin_instruction_path(@instruction), notice: 'Instruction was successfully created.' }
	        format.json { render json: @instruction, status: :created, location: @instruction }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @instruction.errors, status: :unprocessable_entity }
	      end
	    end
		
	end
	
	def create
		
	    @instruction = Instruction.new( params[ :instruction ] )

	    respond_to do |format|
	      if @instruction.save
	        format.html { redirect_to admin_instruction_path(@instruction), notice: 'Instruction was successfully created.' }
	        format.json { render json: @instruction, status: :created, location: @instruction }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @instruction.errors, status: :unprocessable_entity }
	      end
	    end
	
	end

private
	def get_instructions
		@instructions = Instruction.order('sort ASC, created_at ASC').all
		
	end


end
