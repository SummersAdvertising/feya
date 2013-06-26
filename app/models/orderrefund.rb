class Orderrefund < ActiveRecord::Base
  attr_accessible :description, :order_id, :status
  validates :description, :order_id, :presence => true

  belongs_to :order
end
