require 'rails_helper'

RSpec.describe Post, type: :model do
  subject {
    described_class.new(
      title: "A valid post title",
      content: "This is a valid post content.",
      user: User.new(username: "testuser", email_address: "test@example.com", password: "securepassword")
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).not_to be_valid
  end

  it "is not valid without content" do
    subject.content = nil
    expect(subject).not_to be_valid
  end

  it { should belong_to(:user) }

  it "has many comments" do
    should have_many(:comments)
  end
end
