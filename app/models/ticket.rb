# encoding: utf-8
class Ticket < ActiveRecord::Base
  attr_accessible :address, :comment, :email, :name, :phone, :status
  
  validates_presence_of :name, :message => '請填寫您的姓名'
  validates_presence_of :phone, :message => '請填寫您的聯絡電話'
  validates_presence_of :email, :message => '請填寫您的電子信箱'
  validates_format_of :email, :with => /^[\w\.]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]{2,3})+$/, :message => "電子信箱格式有誤"
  
end
