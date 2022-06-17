class Api::V1::RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    user = User.new
    user.name = params[:name]
    user.email = params[:email]
    user.password = params[:password]

    if params[:email].present? && params[:password].present?
      user.token = AuthTokenService.call(params[:email], params[:password])
      user.confirmed_at = Time.now
      if user.save
        render json: { message: 'Signed Up!', token: user.token }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Email and Password are required' }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e }
  end
end
