class CreateTracebooks < ActiveRecord::Migration
  def change
    create_table :tracebooks do |t|
      t.integer :member_id
      t.integer :product_id

      t.timestamps
    end
  end
end
