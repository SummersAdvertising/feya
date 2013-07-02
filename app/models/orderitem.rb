class Orderitem < ActiveRecord::Base
  attr_accessible :amount, :order_id, :stock_id, :status, :itemprice, :itemname, :itemtype
  belongs_to :order
  validates :amount, :order_id, :stock_id, :itemprice, :itemname, :itemtype, :presence => true
end
