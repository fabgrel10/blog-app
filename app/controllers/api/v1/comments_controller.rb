class Api::V1::CommentsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    render json: post.comments, status: :ok
  rescue StandardError => e
    render json: { error: e }, status: :not_found
  end

  def show
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    comment = post.comments.find(params[:id])
    render json: comment, status: :ok
  rescue StandardError => e
    render json: { error: e }, status: :not_found
  end

  def create
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    comment = post.comments.build(comment_params)
    comment.author_id = current_user.id
    render json: comment, status: :ok if comment.save
  rescue StandardError => e
    render json: { error: e }, status: :error
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
