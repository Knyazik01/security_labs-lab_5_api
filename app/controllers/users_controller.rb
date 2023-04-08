class UsersController < ApplicationController
  before_action :authorize_request, only: [:show]

  def show
    # filter password digest field
    user_responce = @current_user.attributes.except('password_digest')
    render json: user_responce, status: :ok
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
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      payload, header = JwtService.decode(header)
      session         = Session.find_by(id: payload['session_id'])
      if session
        @current_user = User.find(payload['user_id'])
      else
        # if session not found
        render json: { error: 'Token expired' }, status: :unauthorized
      end
    rescue JWT::DecodeError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end

  def user_params
    params.permit(:name, :login, :password)
  end
end
