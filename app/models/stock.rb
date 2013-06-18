class Stock < ActiveRecord::Base
  attr_accessible :amount, :product_id, :typename
  validates :typename, :uniqueness => true

  belongs_to :product
end
