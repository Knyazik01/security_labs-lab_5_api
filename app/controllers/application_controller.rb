class ApplicationController < ActionController::API
  def get_current_user
    current_user, error_message = UserService.current_user(request)

    render json: { error: error_message }, status: :unauthorized unless current_user

    current_user
  end
end
