# encoding: utf-8
class Admin < ActiveRecord::Base
  attr_accessible :email, :password, :username, :mail_flag
  before_save :encrypt_psw
  
  validates_presence_of :password, :message => "密碼不得空白"
  
  validates_format_of :email, :with => /^\w+@[a-zA-Z0-9\-\_\.]+(\.[a-zA-Z]{2,3})+$/, :message => "電子信箱格式有誤"

  validates_presence_of :password_confirmation, :if => :password_changed?
  validates_confirmation_of :password, :if => :password_changed?, :message => '密碼確認錯誤，請重新輸入。'

  def encrypt_psw
    self.password = Digest::SHA1.hexdigest(self.password)
  end
end
