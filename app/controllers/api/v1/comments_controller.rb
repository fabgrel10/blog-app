class Api::V1::CommentsController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery unless: -> { request.format.json? }
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
    user = User.where(token: params[:token])[0]
    post = Post.find(params[:post_id])
    comment = post.comments.new(text: params[:text])
    comment.author_id = user.id
    render json: comment, status: :ok if comment.save
  rescue StandardError => e
    render json: { error: e }
  end
end
