class Order < ActiveRecord::Base
  attr_accessible :member_id, :shippingcode, :shippingfee, :shippingway, :status
end
