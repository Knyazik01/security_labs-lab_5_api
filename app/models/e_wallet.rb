class EWallet < ApplicationRecord
  belongs_to :user
  belongs_to :currency

  before_save :set_defaults

  validates :user_id, presence: true
  validates :currency_id, presence: true

  def set_defaults
    self.count ||= 0
  end
end
