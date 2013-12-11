class Category < ActiveRecord::Base
	acts_as_nested_set

  attr_accessible :depth, :lft, :name, :parent_id, :rgt, :status, :type
  
  has_many :products
end
