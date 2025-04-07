class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy

  # Friendship associations
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend
  has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :received_friends, through: :received_friendships, source: :user

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def friend_request_sent?(user)
    friendships.pending.exists?(friend: user)
  end

  def friend_request_received?(user)
    received_friendships.pending.exists?(user: user)
  end

  def friends_with?(user)
    friendships.accepted.exists?(friend: user)
  end

  def pending_friend_requests
    received_friendships.pending
  end
end
