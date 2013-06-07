class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :amount
      t.text :size
      t.text :color
      t.integer :price
      t.integer :saleprice
      t.string :status

      t.timestamps
    end
  end
end
