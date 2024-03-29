class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :user_id, uniqueness: { scope: :product_id, message: "has already purchased this product" }
end
