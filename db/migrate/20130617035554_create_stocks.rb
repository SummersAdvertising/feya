class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :product_id
      t.integer :productsize_id
      t.integer :productcolor_id
      t.integer :amount

      t.timestamps
    end
  end
end
