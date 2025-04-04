class Post < ApplicationRecord
  attribute :content
  attribute :title

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def create
  @post = Post.new(params[:post].permit(:title, :content))

    if @post.save
      redirect_to @post
    else
      render Post.new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(params[:post].permit(:title, :content))
      redirect_to @post
    else
      render Post.edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  private
   def post_params
    params.require(:post).permit(:title, :content)
   end
end
