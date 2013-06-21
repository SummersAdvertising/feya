class CreateOrderlogs < ActiveRecord::Migration
  def change
    create_table :orderlogs do |t|
      t.integer :order_id
      t.string :description

      t.timestamps
    end
  end
end
