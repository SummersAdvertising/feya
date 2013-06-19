class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :saleprice, :status

  has_many :stocks, :dependent => :destroy
end
