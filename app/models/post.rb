class Post < ActiveRecord::Base
  belongs_to :group
  validates_presence_of :content
end