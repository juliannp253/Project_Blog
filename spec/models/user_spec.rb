require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(
      username: "testuser",
      email_address: "test@example.com",
      password: "securepassword"
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is valid with a unique email address" do
    another_user = User.new(email_address: "test@example.com")
    expect(another_user).not_to be_valid
  end

  it "is not valid without an email_address" do
    subject.email_address = nil
    expect(subject).not_to be_valid
  end

  it "is not valid with an improperly formatted email_address" do
    subject.email_address = "invalid_email"
    expect(subject).not_to be_valid
  end

  it "is not valid without a password" do
    subject.password = nil
    expect(subject).not_to be_valid
  end

  it "is not valid if password is too short" do
    subject.password = "123"
    expect(subject).not_to be_valid
  end

  it { should have_many(:posts) }
  it { should have_many(:comments) }
end
