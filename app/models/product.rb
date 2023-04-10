class Product < ApplicationRecord
  belongs_to :currency
  has_many :purchases
end
