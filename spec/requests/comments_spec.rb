require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let!(:user) { User.create(username: "testuser", email_address: "test@example.com", password: "password123") }
  let!(:post_record) { Post.create(title: "Post title", content: "Post content", user: user) }

  describe "When not signed in" do
    it "does not allow comment creation" do
      expect {
        post post_comments_path(post_record), params: { comment: { content: "Unauthorized comment" } }
      }.not_to change(Comment, :count)

      expect(response).to redirect_to(new_session_path)
    end

    it "does not allow comment deletion" do
      comment = Comment.create(content: "Comment", user: user, post: post_record)

      delete post_comment_path(post_record, comment)
      expect(response).to redirect_to(new_session_path)
    end
  end
end
