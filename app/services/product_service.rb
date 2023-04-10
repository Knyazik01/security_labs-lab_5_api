class ProductService
  def self.get_products_user_bought(user_id)
    Product
      .left_outer_joins(:purchases)
      .where(purchases: { user_id: user_id })
  end

  def self.is_user_bought(product_id, user)
    !!Purchase.find_by(user_id: user.id, product_id: product_id)
  end
end