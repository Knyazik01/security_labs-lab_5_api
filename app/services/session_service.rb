class SessionService
  def self.create_unique_user_session(user_id)
    # destroy prev session for this user if exists
    prev_session = Session.find_by(user_id: user_id)
    prev_session.destroy if prev_session

    Session.new(user_id: user_id)
  end

  def self.get_user_data_from_auth_string(auth_string)
    user_data_json = AuthStringService.decrypt(auth_string)
    JSON.parse(user_data_json)
  end
end
