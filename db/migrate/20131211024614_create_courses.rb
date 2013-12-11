class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :instruction_id
      t.integer :article_id
      t.text :description
      t.string :status
      t.integer :sort

      t.timestamps
    end
  end
end
