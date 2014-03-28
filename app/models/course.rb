# encoding: utf-8
class Course < ActiveRecord::Base
  attr_accessible :article_id, :description, :instruction_id, :name, :sort, :status, :cover, :price, :sell, :quota, :credit_form
  
  

  mount_uploader :cover, CourseUploader
  mount_uploader :credit_form, CreditFormUploader
  
  belongs_to :article, :dependent => :destroy
  belongs_to :instruction
  
  has_many :inquirements
  
  before_save :defaults
  
  validates_presence_of :name, :message => '課程名稱為必填'
  validates_presence_of :price, :message => '課程售價為必填'
  
  validates_numericality_of :sell, :message => '優惠價必須為數字', :unless => "sell.nil?"
  validates_numericality_of :price,  :message => '價格必須為大於優惠價的數字', :greater_than => :sell, :unless => "sell.nil?"

  validates_numericality_of :quota, :message => '名額必須為數字', :unless => "quota.nil?"
  
  def defaults
  	self.status ||= 'enable' 
  end
  
end
