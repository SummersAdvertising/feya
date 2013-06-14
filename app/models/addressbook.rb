class Addressbook < ActiveRecord::Base
  attr_accessible :address, :member_id, :name
  validates :address, :member_id, :presence => true
  validates :address, :uniqueness => true
  validates :name, :uniqueness => true, :if => :is_not_blank?

  belongs_to :member

  def is_not_blank?
  	name && name.length > 0
  end
  
end
