class Instruction < ActiveRecord::Base
  attr_accessible :description, :name, :sort, :status, :cover
  has_many :courses
  
  mount_uploader :cover, InstructionUploader
  
end
