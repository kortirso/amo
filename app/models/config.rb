# Represents configuration
class Config < ApplicationRecord
  validates :api_key, presence: true

  class << self
    def current_key
      Config.last.try(:api_key)
    end
  end
end
