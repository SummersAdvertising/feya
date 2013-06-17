class Stock < ActiveRecord::Base
  attr_accessible :amount, :product_id, :productcolor_id, :productsize_id
end
