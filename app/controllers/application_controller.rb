class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    Rails.logger.info("Received Authorization Header: #{token}")
    render json: { error: 'Unauthorized' }, status: :unauthorized unless valid_token?(token)
  end

  private

  def valid_token?(token)
    Rails.logger.info("Validating Token: #{token}")
    return false if token.nil?

    begin
      Rails.logger.info("Validating Token: #{Rails.application.secrets.secret_key_base}")
      JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    rescue JWT::DecodeError
      false
    end
  end
end
