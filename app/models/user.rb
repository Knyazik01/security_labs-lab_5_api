class User < ApplicationRecord
  has_many :e_wallet

  has_secure_password
  before_save :set_defaults
  after_create :create_user_wallets

  VALID_LOGIN_REGEX = /\A\w+\z/
  VALID_LOGIN_MESSAGE = 'can only contain letters, numbers, or underscores'

  validates :name, presence: true
  validates :login, presence: true,
    length: { minimum: 3, maximum: 50 },
    uniqueness: true,
    format: { with: VALID_LOGIN_REGEX, message: VALID_LOGIN_MESSAGE }
  validates :password, presence: true

  def self.authenticate(login, password)
    user = find_by(login: login)
    return user if user&.authenticate(password)
  end

  def set_defaults
    # self.name ||= login
  end

  def create_user_wallets
    Currency.all.each do |currency|
      EWallet.create(user: self, currency: currency)
    end
  end
end
