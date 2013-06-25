class Addressbook < ActiveRecord::Base
  attr_accessible :address, :member_id
  validates :address, :member_id, :presence => true
  validates :address, :uniqueness => true

  belongs_to :member

  validate :record_limit, :on => :create

  def record_limit
    if self.member.addressbooks(:reload).count >= 5
      errors.add(:base, "can only has 5 addresses in book")
    end
  end
    
end
