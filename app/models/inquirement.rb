class Inquirement < ActiveRecord::Base
  attr_accessible :course_id, :description, :email, :name, :phone
  
  belongs_to :course
  
end
