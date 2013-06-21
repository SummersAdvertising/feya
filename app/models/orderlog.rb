class Orderlog < ActiveRecord::Base
  attr_accessible :description, :order_id

  belongs_to :order
end
