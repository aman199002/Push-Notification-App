class User < ActiveRecord::Base
  acts_as_authentic	do |u|  	
  	u.login_field = :email        
  end	
  attr_accessible :email, :password, :password_confirmation, :identifier_url, :first_name, :last_name
  validates :first_name, :presence => true
  has_many :posts

  def full_name
  	self.first_name + " " + self.last_name
  end	
end
