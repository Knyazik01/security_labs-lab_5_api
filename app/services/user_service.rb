class UserService
  def self.current_user(request)
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    @current_user = nil
    @error_message = nil
    begin
      payload, header = JwtService.decode(header)
      session         = Session.find_by(id: payload['session_id'])
      if session
        @current_user = User.find(payload['user_id'])
      else
        # if session not found
        @error_message = 'Token expired'
      end
    rescue
      @error_message = 'Invalid token'
    end

    [@current_user, @error_message]
  end
end
