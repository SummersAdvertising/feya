class Product < ActiveRecord::Base
  attr_accessible :amount, :color, :description, :name, :price, :saleprice, :size, :status

  has_many :productsizes, :dependent => :destroy
  has_many :productcolors, :dependent => :destroy
end
