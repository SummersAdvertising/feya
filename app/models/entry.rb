class Entry < ActiveRecord::Base
  attr_accessible :article_id, :status, :title
  belongs_to :article, :dependent => :destroy
  
  
end