class Post < ActiveRecord::Base
  belongs_to :group
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  validates_presence_of :content

  scope :desc, -> { order('updated_at DESC') }

  def editable_by?(user)
    user && user == author
  end
end
