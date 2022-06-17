class Api::V1::UsersController < ApplicationController
  def index
    return unless current_user.role.eql? 'admin'

    users = User.all
    render json: users, status: :ok
  end

  def show
    return unless current_user == User.find(params[:id]) || (current_user.role.eql? 'admin')

    user = User.find(params[:id])
    render json: user, status: :ok
  rescue StandardError => e
    render json: { error: e }, status: :not_found
  end
end
