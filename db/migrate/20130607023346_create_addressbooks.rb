class CreateAddressbooks < ActiveRecord::Migration
  def change
    create_table :addressbooks do |t|
      t.integer :member_id
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
