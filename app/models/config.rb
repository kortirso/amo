# Represents configuration
class Config < ApplicationRecord
  validates :login, :api_key, presence: true

  class << self
    def current
      Config.last
    end
  end
end
