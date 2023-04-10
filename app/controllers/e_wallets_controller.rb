class EWalletsController < ApplicationController
  before_action :authorize_request

  def show
    user_wallets = EWallet.where(user_id: @current_user.id)
    render json: user_wallets.as_json(include: :currency, except: :user_id), status: :ok
  end

  def add_funds
    amount = params[:amount].to_f
    if amount <= 0
      render json: { error: 'Amount must be greater than 0' }, status: :unprocessable_entity
    else
      e_wallet = EWallet.where(id: params[:e_wallet_id], user_id: @current_user.id).first
      if e_wallet
        e_wallet.update(count: e_wallet.count + amount)
        if e_wallet.save
          # @todo add row to transactions table
          user_wallets = EWallet.where(user_id: @current_user.id)
          render json: user_wallets.to_json(include: :currency), status: :ok
        else
          render json: { error: 'Failed to add funds to e-wallet' }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Invalid e-wallet id' }, status: :unprocessable_entity
      end
    end
  end

  def authorize_request
    @current_user = get_current_user
  end
end
