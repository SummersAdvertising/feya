class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :address
      t.text :comment
      t.string :status

      t.timestamps
    end
  end
end
