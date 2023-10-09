class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    token2 = request.headers['Authorization']
    Rails.logger.info("Received Authorization Header: #{token}")
    Rails.logger.info("Received Authorization Header: #{token2}")
    render json: { error: 'Unauthorized' }, status: :unauthorized unless valid_token?(token)
  end

  private

  def valid_token?(token)
    Rails.logger.info("Validating Token: #{token}")
    return false if token.nil?

    begin
      JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    rescue JWT::DecodeError
      false
    end
  end
end
