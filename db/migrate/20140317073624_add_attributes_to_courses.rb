class AddAttributesToCourses < ActiveRecord::Migration
  def change
  	add_column :courses, :price, :integer
  	add_column :courses, :sell, :integer
  	
  	add_column :courses, :quota, :integer
  	  	
  end
end
