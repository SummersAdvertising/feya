class Admin::CategoriesController < AdminController

	before_filter :get_categories, :only => [ :index, :show, :new, :edit ]

	def new
		@category = Category.new
	end
	
	def edit
		@category = Category.find( params[ :id ] )
	end

	def index
	
		respond_to do | format |
			if @categories.first.nil?
				format.html { render :show }
			else
				format.html{ redirect_to admin_category_path @categories.first }
			end
		end
		
	end
	
	def show		
		@category = Category.find( params[ :id ] )
		@products = @category.products.page( params[ :page ] )
	end
	
	def update
		@category = Category.find( params[ :id ] )
		
		respond_to do |format|
	      if @category.update_attributes( params[ :category ] )
	        format.html { redirect_to admin_category_path(@category), notice: 'Category was successfully created.' }
	        format.json { render json: @category, status: :created, location: @category }
	      else
	      	flash[ :warning ] = @instruction.errors.messages.values.flatten.join('<br>')
	      	get_categories()
	        format.html { render action: "edit" }
	        format.json { render json: @category.errors, status: :unprocessable_entity }
	      end
	    end
		
	end
	
	def create
		
	    @category = Category.new( params[ :category ] )

	    respond_to do |format|
	      if @category.save
	        format.html { redirect_to admin_category_path(@category), notice: 'Category was successfully created.' }
	        format.json { render json: @category, status: :created, location: @category }
	      else
	      	flash[ :warning ] = @instruction.errors.messages.values.flatten.join('<br>')
	      	get_categories()
	        format.html { render action: "new" }
	        format.json { render json: @category.errors, status: :unprocessable_entity }
	      end
	    end
	
	end


	def destroy
		@category = Category.find( params[ :id ] )
		@category.destroy
		
		respond_to do | format |
			format.html{ redirect_to admin_categories_path }
		end
		
	end

private
	def get_categories
		@categories = Category.order('lft ASC, created_at ASC').all
		
	end


end
