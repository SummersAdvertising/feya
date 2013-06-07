class Addressbook < ActiveRecord::Base
  attr_accessible :address, :member_id, :name
end
