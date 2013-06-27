class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :address, :tel
  validates :username, :tel, :presence => true
  before_save :checkpoints

  def checkpoints
    if(!self.discountpoint || self.discountpoint < 0 )
      self.discountpoint = 0
    end    
  end
  
  has_many :addressbooks, :dependent => :destroy
  has_many :tracebooks, :dependent => :destroy
  has_many :orders
end
