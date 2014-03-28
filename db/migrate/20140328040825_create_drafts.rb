class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.string :name
      t.content :text
      t.integer :article_id

      t.timestamps
    end
  end
end
