class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  def generate_tokens
    {
      access_token: generate_jwt,
      refresh_token: generate_refresh_token
    }
  end

  def generate_jwt
    JWT.encode({ id: id, exp: 5.days.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end

  def generate_refresh_token
    SecureRandom.hex(32)
  end
end
