class Orderitem < ActiveRecord::Base
  attr_accessible :amount, :order_id, :product_id, :status
end
