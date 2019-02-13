class Group < ActiveRecord::Base
  has_many :posts
  validates_presence_of :title, :description
end