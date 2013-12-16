class Testimony < ActiveRecord::Base
  attr_accessible :article_id, :cover, :status, :title, :cover
  
  mount_uploader :cover, TestimonyUploader
  
  belongs_to :article, :dependent => :destroy
  
end
