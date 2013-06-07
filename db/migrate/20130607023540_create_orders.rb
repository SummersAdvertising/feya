class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :member_id
      t.integer :shippingfee
      t.string :status
      t.string :shippingway
      t.string :shippingcode

      t.timestamps
    end
  end
end
