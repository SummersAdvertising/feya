class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.string :name
      t.text :content
      t.integer :article_id

      t.timestamps
    end
  end
end
