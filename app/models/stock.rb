class Stock < ActiveRecord::Base
  attr_accessible :amount, :product_id, :typename
  validates_uniqueness_of :typename, :scope => [:product_id]
  validate :amount_value

  def amount_value
  	if (!self.amount || !(self.amount.is_a? Integer) || self.amount <= 0)
  		errors.add(:amount, "amount must be a positive number.")
  	end
  end

  belongs_to :product
end
