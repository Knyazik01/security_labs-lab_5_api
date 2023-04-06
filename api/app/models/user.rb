class User < ApplicationRecord
  has_secure_password
  before_save :set_defaults

  validates :login, presence: true, uniqueness: true

  def self.authenticate(login, password)
    user = find_by(login: login)
    return user if user&.authenticate(password)
  end

  def set_defaults
  end
end
