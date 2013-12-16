# encoding: utf-8
class Testimony < ActiveRecord::Base
  attr_accessible :article_id, :cover, :status, :title, :cover
  
  mount_uploader :cover, TestimonyUploader
  
  belongs_to :article, :dependent => :destroy
   
  validates_presence_of :title, :message => '名稱為必填'
 
end
