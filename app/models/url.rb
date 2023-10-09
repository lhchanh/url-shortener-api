class Url < ApplicationRecord
  validates :original_url, presence: true, format: URI::regexp(%w[http https])

  before_create :generate_short_url

  def generate_short_url
    self.short_url = SecureRandom.hex(3)
  end
end

