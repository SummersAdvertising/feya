class AddCoverToInstrucitons < ActiveRecord::Migration
  def change  
  	add_column :instructions, :cover, :string
  end
end
