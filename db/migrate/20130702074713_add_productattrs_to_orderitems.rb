class AddProductattrsToOrderitems < ActiveRecord::Migration
  def change
    add_column :orderitems, :itemname, :string
    add_column :orderitems, :itemtype, :string
  end
end
