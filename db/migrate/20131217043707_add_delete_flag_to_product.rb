class AddDeleteFlagToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :delete_flag, :boolean
  end
end
