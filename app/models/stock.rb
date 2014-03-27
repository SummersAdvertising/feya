# encoding: utf-8
class Stock < ActiveRecord::Base
  attr_accessible :amount, :product_id, :typename
  validates :typename, :presence => { :message => '庫存名稱不得空白'}
  validates_uniqueness_of :typename, :scope => [:product_id]
  validate :amount_value, :if => :is_amount?
  
  validates_numericality_of :amount_value, :message => '數量必須為正整數', :unless => 'amount_value.nil?'

  def is_amount?
  	self.amount 	
  end

  def amount_value
  	if (!(self.amount.is_a? Integer) || self.amount < 0)
  		errors.add(:amount, "數量必須為正整數")
  	end
  end

  belongs_to :product
end
