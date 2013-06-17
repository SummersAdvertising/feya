class CreateProductsizes < ActiveRecord::Migration
  def change
    create_table :productsizes do |t|
      t.integer :product_id
      t.string :name

      t.timestamps
    end
  end
end
