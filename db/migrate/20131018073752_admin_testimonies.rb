class AdminTestimonies < ActiveRecord::Migration
  def change
    create_table :testimonies do |t|
      t.string :title
      t.integer :article_id
      t.string :cover
      t.string :status

      t.timestamps
    end
  end
end
