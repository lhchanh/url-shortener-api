module Api
  class RegistrationsController < ApplicationController
    skip_before_action :authenticate_user!

    def create
      user = User.new(user_params)

      if user.save
        tokens = user.generate_tokens
        render json: tokens, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end
