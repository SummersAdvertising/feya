# encoding: utf-8
class Course < ActiveRecord::Base
  attr_accessible :article_id, :description, :instruction_id, :name, :sort, :status, :cover

  mount_uploader :cover, CourseUploader
  
  belongs_to :article, :dependent => :destroy
  belongs_to :instruction
  
  before_save :defaults
  
  validates_presence_of :name, :message => '課程名稱為必填'
  
  def defaults
  	self.status ||= 'enable' 
  end
  
end
