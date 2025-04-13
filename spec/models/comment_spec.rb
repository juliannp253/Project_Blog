require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject {
    described_class.new(
      content: "This is a valid comment.",
      user: User.new(username: "testuser", email_address: "test@example.com", password: "securepassword"),
      post: Post.new(title: "Post title", content: "Post content")
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without content" do
    subject.content = nil
    expect(subject).not_to be_valid
  end

  it "is not valid if content is too short" do
    subject.content = "Hi"
    expect(subject).not_to be_valid
  end

  it "is not valid without a user" do
    subject.user = nil
    expect(subject).not_to be_valid
  end

  it "is not valid without a post" do
    subject.post = nil
    expect(subject).not_to be_valid
  end

  it { should belong_to(:user) }
  it { should belong_to(:post) }
end
