class Productsize < ActiveRecord::Base
  attr_accessible :name, :product_id

  validates :name, :presence => true
  validates :name, :uniqueness => true
  
  belongs_to :product
end
