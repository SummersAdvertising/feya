class Orderrefund < ActiveRecord::Base
  attr_accessible :description, :order_id, :status

  belongs_to :order
end
