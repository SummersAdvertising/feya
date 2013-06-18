class Product < ActiveRecord::Base
  attr_accessible :amount, :color, :description, :name, :price, :saleprice, :size, :status

  has_many :stocks, :dependent => :destroy
end
