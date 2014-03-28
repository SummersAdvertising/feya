#encoding: utf-8
class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :saleprice, :cover

 validates_presence_of :name, :message => '產品名稱不得空白'
 validates_presence_of :price, :message => '請輸入產品價格'
 
 validates_numericality_of :price, :message => '價格必須為正整數字'
 validates_numericality_of :saleprice, :message => '折扣價必須為正整數字', :greater_than => 0, :unless => "saleprice.nil?" 
 
 validates_numericality_of :price, :message => '售價不得低於折扣價', :greater_than => :saleprice, :unless => "saleprice.nil?" 
  
  belongs_to :article, :dependent => :destroy
  
  belongs_to :category

  mount_uploader :cover, ProductcoverUploader

  paginates_per 20

  has_many :stocks, :dependent => :destroy
end
