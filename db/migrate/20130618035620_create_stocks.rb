class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :product_id
      t.string :typename
      t.integer :amount

      t.timestamps
    end
  end
end
