class Orderlog < ActiveRecord::Base
  attr_accessible :description, :order_id
  validates :description, :order_id, :presence => true

  belongs_to :order
end
