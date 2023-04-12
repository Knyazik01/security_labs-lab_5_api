class ProductService
  def self.get_products_user_bought(user)
    purchased_product_ids = Purchase.where(user: user).pluck(:product_id)
    Product.where(id: purchased_product_ids).order(:id)
  end

  def self.get_products_user_can_buy(user)
    purchased_product_ids = Purchase.where(user: user).pluck(:product_id)
    Product.where.not(id: purchased_product_ids).order(:id)
  end

  def self.is_user_bought(product_id, user)
    !!Purchase.find_by(user_id: user.id, product_id: product_id)
  end
end