class Photo < ActiveRecord::Base
  belongs_to :article
  belongs_to :draft
  
  attr_accessible  :image

  mount_uploader :image, ImageUploader
  
  before_create :update_filename
  #validates_uniqueness_of :name, :on => :create
  
  before_destroy :remove_file
  
  def mark_deleting
  	unless self.status  == 'drafting'
	  	self.update_attribute( 'status', 'deleting' )
	end
  end
  
  private
  
  def remove_file  
    @photopath = "public/uploads/"+ self.article_id.to_s + "/" + self.id.to_s + "-" + self.name
    Rails.logger.debug " **** Entering debug **** "
    Rails.logger.debug @photopath.inspect
    Rails.logger.debug " **** End **** "
    File.delete(@photopath) #carrierwave will handle this.
  end
  
  def update_filename
  	self.name = image.file.filename
  end

end
