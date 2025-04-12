class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy

  # Friendship associations
  has_many :friendships, dependent: :destroy
  has_many :friends, -> { where(friendships: { status: :accepted }) },
           through: :friendships,
           source: :friend

  has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :received_friends, through: :received_friendships, source: :user

  has_many :received_friendship_requests, -> { where(status: "pending") },
           class_name: "Friendship",
           foreign_key: "friend_id"
  has_many :pending_sent_requests, -> { where(status: "pending") },
           class_name: "Friendship",
           foreign_key: "user_id"

  normalizes :email_address, with: ->(email) { email.strip.downcase }

  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, on: :create, length: { minimum: 6 }
  validates :username, presence: true
  def friend_request_sent?(user)
    friendships.pending.exists?(friend: user)
  end

  def friend_request_received?(user)
    received_friendships.pending.exists?(user: user)
  end

  def friends_with?(user)
    friendships.accepted.exists?(friend: user) || received_friendships.accepted.exists?(user: user)
  end

  def pending_friend_requests
    received_friendships.pending
  end

  def can_send_friend_request_to?(user)
    self != user &&
    !friends.include?(user) &&
    !pending_sent_requests.exists?(friend: user) &&
    !received_friendship_requests.exists?(user: user)
  end
end
