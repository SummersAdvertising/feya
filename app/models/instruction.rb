class Instruction < ActiveRecord::Base
  attr_accessible :description, :name, :sort, :status
  has_many :courses
  
  
end
