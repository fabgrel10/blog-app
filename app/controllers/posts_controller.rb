class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @user_posts = Post.includes(:comments, comments: [:author]).where(author_id: @user.id).order(id: :desc)
  end

  def show
    @user = User.find(params[:user_id])
    @current_post = Post.includes(:comments, comments: [:author]).where(author_id: @user.id).find(params[:id])
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

  def destroy
    @post = Post.find(params[:id])
    @post.decrement_posts_counter
    @post.delete
    redirect_to user_path(@post.author_id), notice: 'Post deleted!'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
