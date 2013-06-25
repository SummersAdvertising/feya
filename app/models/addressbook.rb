class Addressbook < ActiveRecord::Base
  attr_accessible :address, :member_id
  validates :address, :member_id, :presence => true
  validates :address, :uniqueness => true

  belongs_to :member
    
end
