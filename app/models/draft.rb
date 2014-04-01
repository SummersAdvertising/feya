class Draft < ActiveRecord::Base
  has_many :photos, class_name: "Photo", primary_key: "article_id", foreign_key: "article_id"
  attr_accessible :article_id, :name, :content
  
  belongs_to :article
  
  before_destroy :clean_images
  
  def clean_images
  	  
	  self.photos.where( "status = 'drafting' OR status = 'deleting'").destroy_all

  end
  
  
end
