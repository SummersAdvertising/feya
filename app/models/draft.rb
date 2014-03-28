class Draft < ActiveRecord::Base
  attr_accessible :article_id, :name, :text
  
  belongs_to :article
  
end
