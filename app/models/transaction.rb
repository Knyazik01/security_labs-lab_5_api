class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :currency

  before_save :set_defaults

  validates :currency_id, presence: true
  validates :user_id, presence: true

  def set_defaults
    self.profit ||= 0
    self.bill ||= 0
  end
end
