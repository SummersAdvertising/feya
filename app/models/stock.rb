class Stock < ActiveRecord::Base
  attr_accessible :amount, :product_id, :typename
  validates_uniqueness_of :typename, :scope => [:product_id]

  belongs_to :product
end
