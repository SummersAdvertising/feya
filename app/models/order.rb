class Order < ActiveRecord::Base
  attr_accessible :member_id, :shippingcode, :shippingfee, :shippingway, :status, :buyername, :buyertel, :invoicetype, :companynum, :receivername, :receiveraddress, :receivertel, :paytype
  validates :member_id, :status, :buyername, :buyertel, :invoicetype, :receivername, :receiveraddress, :receivertel, :paytype, :presence => true

  has_many :orderitems, :dependent => :destroy
end
