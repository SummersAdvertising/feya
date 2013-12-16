#encoding: utf-8
class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :saleprice, :cover
 # validates :name, :price, :presence => true
 #validate :price_value
  
  belongs_to :article, :dependent => :destroy
  
  belongs_to :category

  mount_uploader :cover, ProductcoverUploader

  paginates_per 20

  def price_value
  	if (!self.price || !(self.price.is_a? Integer) || self.price <= 0)
  		errors.add(:price, "price must be a positive number.")
  	end
  end

  has_many :stocks, :dependent => :destroy
end
