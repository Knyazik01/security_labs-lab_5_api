class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :currency

  validates :currency_id, presence: true
  validates :user_id, presence: true
end
