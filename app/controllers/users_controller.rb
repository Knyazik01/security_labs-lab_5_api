class UsersController < ApplicationController
  before_action :authorize_request, only: [:show]

  def show
    render json: @current_user.as_json(except: :password_digest), status: :ok
  end

  def create
    user = User.new(user_params)

    if user.valid?
      if user.save
        user_json = JSON.dump({ login: user_params[:login], password: user_params[:password] })
        auth_string = AuthStringService.encrypt(user_json)

        # send_data auth_string, filename: 'auth_string', type: "text/plain", disposition: "attachment"
        render json: { auth_string: auth_string }, status: :created
      else
        render json: { message: 'Cannot create user' }, status: :bad_request
      end
    else
      render json: user.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def authorize_request
    @current_user = get_current_user
  end

  def user_params
    params.permit(:name, :login, :password)
  end
end
