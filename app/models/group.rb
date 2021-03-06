class Group < ActiveRecord::Base
  has_many :posts
  has_many :group_users
  has_many :members, through: :group_users, source: :user
  belongs_to :owner, class_name: 'User', foreign_key: :user_id

  scope :desc_by_posts_count, -> { order('posts_count DESC') }

  validates_presence_of :title, :description

  after_create :join_owner_to_group

  def editable_by?(user)
    user && user == owner
  end

  def join_owner_to_group
    members << owner
  end
end
