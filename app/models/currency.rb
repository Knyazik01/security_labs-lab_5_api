class Currency < ApplicationRecord
  has_many :e_wallets
  has_many :transactions

  after_create :create_wallets_for_currency
  before_destroy :delete_wallets_for_currency

  def create_wallets_for_currency
    User.all.each do |user|
      EWallet.create(user: user, currency: self)
    end
  end

  def delete_wallets_for_currency
    self.e_wallets.destroy_all
  end
end
