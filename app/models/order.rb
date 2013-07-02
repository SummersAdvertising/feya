#encoding: UTF-8
class Order < ActiveRecord::Base
  attr_accessible :member_id, :shippingcode, :shippingfee, :shippingway, :status, :buyername, :buyertel, :invoicetype, :invoicename, :companynum, :receivername, :receiveraddress, :receivertel, :paytype, :paydate, :paytime, :payaccount
  validates :member_id, :status, :buyername, :buyertel, :invoicetype, :receivername, :receiveraddress, :receivertel, :paytype, :presence => true
  validates :shippingcode, :shippingway, :presence => true, :if => :is_finish?
  validates :invoicename, :companynum, :presence => true, :if => :is_company?

  before_save :checkpoints

  def checkpoints
    if(!self.discountpoint || self.discountpoint < 0 )
      self.discountpoint = 0
    end    
  end

  def is_finish?
    self.status == "finish"
  end

  def is_company?
    self.invoicetype == "三聯式"
  end

  belongs_to :member
  has_many :orderitems, :dependent => :destroy
  has_many :orderrefunds, :dependent => :destroy
  has_many :orderlogs, :dependent => :destroy
end
