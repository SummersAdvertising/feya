class AddCourseInstructionNameToInquirements < ActiveRecord::Migration
  def change
  	add_column :inquirements, :instruction_name, :string
  	add_column :inquirements, :course_name, :string
  end
end
