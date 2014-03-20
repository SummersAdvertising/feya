# encoding: utf-8
class Admin < ActiveRecord::Base
  attr_accessible :email, :password, :username, :mail_flag
  before_save :encrypt_psw
  
  validates_confirmation_of :password, :if => :password_changed?, :message => '密碼確認錯誤，請重新輸入。'

  def encrypt_psw
    self.password = Digest::SHA1.hexdigest(self.password)
  end
end
