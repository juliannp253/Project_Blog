class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [ :edit, :update, :destroy ]
  before_action :authorize_comment!, only: [ :edit, :update, :destroy ]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), notice: "Comment added successfully."
    else
      redirect_to post_path(@post), alert: "Failed to add comment."
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: "Comment updated successfully."
    else
      render :edit, alert: "Failed to update comment."
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post), notice: "Comment deleted successfully."
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def authorize_comment!
    redirect_to post_path(@post), alert: "Not authorized." unless @comment.user == current_user
  end
end
