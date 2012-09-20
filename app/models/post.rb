class Post < ActiveRecord::Base
  attr_accessible :description, :name, :user_id
  belongs_to :user
  validates :name, :description, :presence => true
  validates :name, :uniqueness => true
end
