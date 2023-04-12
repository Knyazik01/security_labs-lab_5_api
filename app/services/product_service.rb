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

  def self.buy_multi_products(products, user)
    success = false
    ActiveRecord::Base.transaction do
      begin
        products.each do |product|
          currency = product.currency
          e_wallet = EWallet.find_by(user: user, currency: currency)
          balance_before = e_wallet.count.truncate(2)
          bill = product.price.truncate(2)
          balance = (balance_before - bill).truncate(2)

          unless balance >= 0
            raise ActiveRecord::Rollback
          end

          # Create transaction
          transaction = Transaction.new(
            user: user,
            currency: currency,
            balance_before: balance_before,
            bill: bill,
            balance: balance
          )

          # change e-wallet balance without save
          e_wallet.assign_attributes(count: balance.truncate(2))

          # create purchase
          purchase = Purchase.new(user: user, product: product)

          puts transaction.inspect
          puts e_wallet.inspect
          puts purchase.inspect

          unless transaction.save && purchase.save && e_wallet.save
            raise ActiveRecord::Rollback
          end
        end
        success = true
      rescue ActiveRecord::Rollback => e
        puts e
        success = false
      end
    end
    { success: success }
  end
end