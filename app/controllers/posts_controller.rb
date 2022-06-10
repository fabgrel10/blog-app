class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user_posts = @user.posts.order('created_at DESC')
  end

  def show
    @current_post = Post.find(params[:id])
    @current_user = current_user
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash.now[:success] = 'Post created!'
      redirect_to user_posts_path
    else
      flash.now[:error] = 'Post could not be created!'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
