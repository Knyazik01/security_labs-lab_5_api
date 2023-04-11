class TransactionsController < ApplicationController
  before_action :authorize_request

  def index
    transactions = Transaction.where(user_id: @current_user.id)
    render json: transactions.to_json(include: :currency)
  end

  private
  def authorize_request
    @current_user = get_current_user
  end
end
