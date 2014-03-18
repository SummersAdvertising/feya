# encoding: utf-8
class Instruction < ActiveRecord::Base
  attr_accessible :description, :name, :sort, :status, :cover
  has_many :courses
  has_many :testimonies
  
  mount_uploader :cover, InstructionUploader
  
  validates_presence_of :name, :message => '名稱為必填'
  
end
