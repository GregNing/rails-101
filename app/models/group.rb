class Group < ActiveRecord::Base
  has_many :posts
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  validates_presence_of :title, :description
end
