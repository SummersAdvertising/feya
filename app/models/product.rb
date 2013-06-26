class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :saleprice, :status
  validates :name, :price, :presence => true
  validate :price_value

  def price_value
  	if self.price <= 0
  		errors.add(:price, "price must be a positive number.")
  	end
  end

  has_many :stocks, :dependent => :destroy
end
