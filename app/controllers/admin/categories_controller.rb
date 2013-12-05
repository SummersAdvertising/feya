class Admin::CategoriesController < AdminController

	def index
		
		@categories = Category.where( "status <> 'disable' " ).order( :lft => :asc )
		
		
	
	end

end
