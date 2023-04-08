class EWalletsController < ApplicationController
  before_action :authorize_request

  def show
    user_wallets = EWallet.where("user_id = #{@current_user.id}")
    render json: user_wallets.to_json(include: :currency, except: :user_id), status: :ok
  end

  def authorize_request
    @current_user = get_current_user
  end
end
