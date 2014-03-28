# encoding: utf-8
class Stock < ActiveRecord::Base
  attr_accessible :amount, :product_id, :typename
  validates :typename, :presence => { :message => '庫存名稱不得空白'}
  validates_uniqueness_of :typename, :scope => [:product_id]
  
  validates_numericality_of :amount, :message => '數量必須為正整數', :greater_than => 0, :unless => 'amount.nil?'


  belongs_to :product
end
