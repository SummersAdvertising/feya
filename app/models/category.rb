# encoding: utf-8
class Category < ActiveRecord::Base
	acts_as_nested_set

  attr_accessible :depth, :lft, :name, :parent_id, :rgt, :status, :type
  
  validates_presence_of :name, :message => '名稱為必填'
  
  has_many :products, :dependent => :destroy
end
