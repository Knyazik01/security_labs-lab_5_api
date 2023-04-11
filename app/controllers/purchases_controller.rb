class PurchasesController < ApplicationController
  before_action :authorize_request

  def create
    product_id = params[:product_id]
    product = Product.find_by(id: product_id)

    if product.nil?
      render json: { error: 'File not found' }, status: :not_found
    else
      is_transaction_success = TransactionService.create(
        @current_user,
        product.currency,
        bill: product.price
      )

      if is_transaction_success
        purchase = Purchase.new(user: @current_user, product: product)

        if purchase.save
          all_user_products = ProductService.get_products_user_bought(@current_user.id)
          render json: {
            message: 'You have successfully purchased this product',
            bought_products: all_user_products.as_json(include: :currency),
          }, status: :ok
        else
          TransactionService.rollback(
            @current_user,
            product.currency,
            bill: product.price
          )
          render json: purchase.errors.messages, status: :unprocessable_entity
        end
      else
        render json: {
          error: 'You cannot purchase this product. Please, top up your e-wallet'
        }, status: :unprocessable_entity
      end
    end
  end

  private

  def authorize_request
    @current_user = get_current_user
  end
end
