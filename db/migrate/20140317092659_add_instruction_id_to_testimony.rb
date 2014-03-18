class AddInstructionIdToTestimony < ActiveRecord::Migration
  def change
  	add_column :testimonies, :instruction_id, :integer
  end
end
