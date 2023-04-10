class SessionsController < ApplicationController
  def create
    auth_string = params[:auth_string]
    begin
      user_data = SessionService.get_user_data_from_auth_string(auth_string)
      puts user_data
      user = User.find_by(login: user_data["login"])

      if user && user.authenticate(user_data["password"])
        session = SessionService.create_unique_user_session user.id

        if session.save
          payload = { user_id: user.id, session_id: session.id }
          token = JwtService.encode(payload)
          render json: {
            token: token,
            user: user.as_json(
              include: { e_wallets: { include: :currency } },
              except: :password_digest
            )
          }, status: :ok
        else
          render json: { error: 'Cannot create session' }, status: :forbidden
        end
      else
        raise SignalException.new('Invalid credentials')
      end
    rescue
      render json: { error: 'Invalid auth string' }, status: :unauthorized
    end
  end

=begin
  def show
    token = request.headers['Authorization']&.split(' ')&.last
    payload, header = JwtService.decode(token)

    if payload && header['alg'] == 'HS256'
      user = User.find_by(id: payload['user_id'])

      if user
        render json: { user: user }
      else
        render json: { error: 'User not found' }, status: :not_found
      end
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
=end

  def destroy
    token = request.headers['Authorization']&.split(' ')&.last
    payload, header = JwtService.decode(token)

    if payload && header['alg'] == 'HS256'
      session = Session.find_by(id: payload['session_id'])
      session.destroy if session

      render json: { message: 'Successfully logged out' }, status: :ok
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end
