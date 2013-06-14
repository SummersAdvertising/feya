class Addressbook < ActiveRecord::Base
  attr_accessible :address, :member_id, :name
  validates :address, :member_id, :presence => true
  validates :address, :uniqueness => true
  validates :name, :uniqueness => true, :if => :is_not_blank?

  def is_not_blank?
  	name.length > 0
  end
  
end
