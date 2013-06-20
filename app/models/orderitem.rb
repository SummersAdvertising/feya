class Orderitem < ActiveRecord::Base
  attr_accessible :amount, :order_id, :stock_id, :status, :itemprice
  belongs_to :order
end
