class CreateInquirements < ActiveRecord::Migration
  def change
    create_table :inquirements do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.text :description
      t.integer :course_id

      t.timestamps
    end
  end
end
