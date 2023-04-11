class Product < ApplicationRecord
  belongs_to :currency
  has_many :purchases

  validates :currency_id, presence: true
end
