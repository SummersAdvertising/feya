class Order < ActiveRecord::Base
  attr_accessible :member_id, :shippingcode, :shippingfee, :shippingway, :status, :buyername, :buyertel, :invoicetype, :companynum, :receivername, :receiveraddress, :receivertel, :paytype, :paydate, :paytime, :payaccount
  validates :member_id, :status, :buyername, :buyertel, :invoicetype, :receivername, :receiveraddress, :receivertel, :paytype, :presence => true
  validates :shippingcode, :shippingway, :presence => true, :if => :is_finish?

  def is_finish?
    self.status == "finish"
  end

  belongs_to :member
  has_many :orderitems, :dependent => :destroy
  has_many :orderrefunds, :dependent => :destroy
  has_many :orderlogs, :dependent => :destroy
end
