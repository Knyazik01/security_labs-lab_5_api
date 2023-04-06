class UsersController < ApplicationController
  before_action :authorize_request

  def show
    # filter password digest field
    user_responce = @current_user.attributes.except('password_digest')
    render json: user_responce, status: :ok
  end

  private

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      payload, header = JwtService.decode(header)
      session = Session.find_by(id: payload['session_id'])
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
end
