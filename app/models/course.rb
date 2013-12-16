class Course < ActiveRecord::Base
  attr_accessible :article_id, :description, :instruction_id, :name, :sort, :status, :cover

  mount_uploader :cover, CourseUploader
  
  belongs_to :article, :dependent => :destroy
  belongs_to :instruction
  
  before_save :defaults
  
  def defaults
  	self.status ||= 'enable' 
  end
  
end
