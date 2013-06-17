class CreateProductcolors < ActiveRecord::Migration
  def change
    create_table :productcolors do |t|
      t.integer :product_id
      t.string :name

      t.timestamps
    end
  end
end
