class Tracebook < ActiveRecord::Base
  attr_accessible :member_id, :stock_id
  validates :member_id, :stock_id, :presence => true
  validates_uniqueness_of :stock_id, :scope => [:member_id]

  belongs_to :member
end
