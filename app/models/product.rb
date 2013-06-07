class Product < ActiveRecord::Base
  attr_accessible :amount, :color, :description, :name, :price, :saleprice, :size, :status
end
