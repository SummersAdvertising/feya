class AddCoverToInstruction < ActiveRecord::Migration
  def change
  	add_column :courses, :cover, :string
  end
end
