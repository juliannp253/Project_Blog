class PostsController < ApplicationController
  before_action :require_authentication
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_post, only: %i[edit update destroy delete_image]

  def index
    #  @posts = if current_user.friends.any?
    #    friend_ids = current_user.friends.pluck(:id)
    #    Post.where(user_id: [ current_user.id, *friend_ids ])
    #  else
    #    current_user.posts
    # end.order(created_at: :desc)

    @posts = Post.all.order(created_at: :desc)
  end

  # ... rest of the controller remains the same ...

  def show
  end

  def my_posts
    @posts = current_user.posts.order(created_at: :desc)
  end
  def new
    @post = Post.new
  end

  def delete_image
    @post = Post.find(params[:id])
    image = @post.images.find(params[:image_id])
    image.purge

    respond_to do |format|
      format.html { redirect_to edit_post_path(@post), notice: "Image was successfully deleted." }
      format.json { head :no_content }
    end
  end


  def edit
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        if params[:post][:images].present?
          @post.images.attach(params[:post][:images])
        end

        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def authorize_post
    unless @post.user == current_user
      redirect_to posts_path, alert: "You are not authorized to perform this action."
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, images: [])
  end
end
