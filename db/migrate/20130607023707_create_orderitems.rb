class CreateOrderitems < ActiveRecord::Migration
  def change
    create_table :orderitems do |t|
      t.integer :order_id
      t.integer :stock_id
      t.integer :amount
      t.string :status

      t.timestamps
    end
  end
end
