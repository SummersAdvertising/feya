class Admin < ActiveRecord::Base
  attr_accessible :email, :password, :username
  before_save :encrypt_psw

  def encrypt_psw
    self.password = Digest::SHA1.hexdigest(self.password)
  end
end
