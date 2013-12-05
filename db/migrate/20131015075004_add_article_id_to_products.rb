class AddArticleIdToProducts < ActiveRecord::Migration
  def change
	add_column :products, :article_id, :integer
  end
end
