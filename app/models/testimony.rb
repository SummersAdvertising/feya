class Testimony < ActiveRecord::Base
  attr_accessible :article_id, :cover, :status, :title
  
  belongs_to :article
  
end
