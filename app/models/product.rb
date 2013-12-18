#encoding: utf-8
class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :saleprice, :cover

 validates_presence_of :name, :message => '產品名稱不得空白'
 validates_presence_of :price, :message => '請輸入產品價格'
 validate :price_value
  
  belongs_to :article, :dependent => :destroy
  
  belongs_to :category

  mount_uploader :cover, ProductcoverUploader

  paginates_per 20

  def price_value
  	if (!self.price || !(self.price.is_a? Integer) || self.price <= 0)
  		errors.add(:price, "價格格式錯誤")
  	end
  end

  has_many :stocks, :dependent => :destroy
end
