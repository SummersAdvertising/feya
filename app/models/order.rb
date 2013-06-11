class Order < ActiveRecord::Base
  attr_accessible :member_id, :shippingcode, :shippingfee, :shippingway, :status, :buyername, :buyertel, :invoicetype, :companynum, :receivername, :receiveraddress, :receivertel, :paytype
end
