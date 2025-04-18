class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :user_id, presence: true
  validates :friend_id, presence: true
  validates :user_id, uniqueness: { scope: :friend_id }
  validate :not_self_referential, on: :create

  enum :status, { pending: 0, accepted: 1 }

  private

  def not_self_referential
    if user_id == friend_id
      errors.add(:friend_id, "can't be the same as user")
    end
  end
end
