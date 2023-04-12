class ProductsController < ApplicationController
  before_action :authorize_request

  def users_bought
    products_user_bought = ProductService.get_products_user_bought(@current_user)
    render json: products_user_bought.to_json(include: :currency), status: :ok
  end

  def user_can_buy
    # Fetch all products that do not have a purchase associated with a specific user_id and product_id
    products_can_buy = ProductService.get_products_user_can_buy(@current_user)

    render json: products_can_buy.to_json(include: :currency), status: :ok
  end

  def download_file
    product_id = params[:product_id]
    can_user_download = ProductService.is_user_bought(product_id, @current_user)
    if can_user_download
      bought_product = Product.find_by(id: product_id)

      if !bought_product.nil?
        file_name = bought_product.name
        file_path = Rails.root.join('storage', 'files', file_name)

        # Check if the file exists
        if File.exist?(file_path)
          send_file(file_path, disposition: 'attachment', filename: file_name)
        else
          render json: { error: 'File not found' }, status: :not_found
        end
      else
        render json: { error: 'Product not found' }, status: :not_found
      end
    else
      render json: { error: 'You cannot download this file' }, status: :forbidden
    end
  end

  private

  def authorize_request
    @current_user = get_current_user
  end
end
