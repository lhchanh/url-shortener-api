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
      secret_key_base = Rails.application.credentials.secret_key_base
  
      Rails.logger.info("Secret Key Base: #{secret_key_base}")
      
      decoded_token = JWT.decode(token, secret_key_base)[0]
      Rails.logger.info("Decoded Token: #{decoded_token}")
  
      decoded_token
    rescue JWT::DecodeError => e
      Rails.logger.error("JWT Decode Error: #{e.message}")
      false
    end
  end
  
end
