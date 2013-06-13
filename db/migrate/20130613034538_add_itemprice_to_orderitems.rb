class AddItempriceToOrderitems < ActiveRecord::Migration
  def change
    add_column :orderitems, :itemprice, :integer
  end
end
