class PurchasesController < ApplicationController
  before_action :authorize_request

  def create
    product_id = params[:product_id]

    # @todo add check price and user balance + add row to transactions table

    purchase = Purchase.new(user_id: @current_user.id, product_id: product_id)

    if purchase.valid?
      if purchase.save
        all_user_products = ProductService.get_products_user_bought(@current_user.id)
        render json: {
          message: 'You have successfully purchased this product',
          bought_products: all_user_products.as_json(include: :currency),
        }, status: :ok
      else
        render json: purchase.errors.messages, status: :unprocessable_entity
      end
    else
      render json: purchase.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def authorize_request
    @current_user = get_current_user
  end
end
