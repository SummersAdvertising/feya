# encoding: utf-8
class Entry < ActiveRecord::Base
  attr_accessible :article_id, :status, :title
  belongs_to :article, :dependent => :destroy
  
  validates_presence_of :title, :message => '標題為必填'
  
  
end