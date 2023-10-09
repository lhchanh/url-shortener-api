module Api
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user!

    def authenticate
      user = User.find_by(email: params[:email])
      
      if user&.authenticate(params[:password])
        token = user.generate_jwt
        render json: { token: token }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end

    def refresh_token
      user = User.find_by(refresh_token: params[:refresh_token])

      if user
        new_access_token = user.generate_jwt
        render json: { access_token: new_access_token }, status: :ok
      else
        render json: { error: 'Invalid refresh token' }, status: :unauthorized
      end
    end
  end
end
