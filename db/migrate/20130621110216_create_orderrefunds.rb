class CreateOrderrefunds < ActiveRecord::Migration
  def change
    create_table :orderrefunds do |t|
      t.integer :order_id
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
