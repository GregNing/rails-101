class Message < ActiveRecord::Base
  validates :content, presence: true

  belongs_to :post, dependent: :destroy
  belongs_to :user, dependent: :destroy

  def user_identity
    self.user.try(:name) || 'visitor'
  end
end
