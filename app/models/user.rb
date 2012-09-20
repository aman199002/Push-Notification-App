class User < ActiveRecord::Base
  acts_as_authentic	
  attr_accessible :name, :login, :email, :password, :password_confirmation
  validates :name, :presence => true
  has_many :posts
end
