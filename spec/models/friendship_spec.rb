require 'rails_helper'

RSpec.describe Friendship, type: :model do
  subject {
    described_class.new(
      user: User.new(username: "testuser", email_address: "test@example.com", password: "securepassword", password_confirmation: "securepassword"),
      friend: User.new(username: "frienduser", email_address: "friend@example.com", password: "securepassword", password_confirmation: "securepassword")
    )
  }

  it "is not valid without a user" do
    subject.user = nil
    expect(subject).not_to be_valid
  end

  it "is not valid without a friend" do
    subject.friend = nil
    expect(subject).not_to be_valid
  end

  it { should belong_to(:user) }
  it { should belong_to(:friend) }
end
