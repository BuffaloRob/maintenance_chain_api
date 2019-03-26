class ApplicationController < ActionController::API
  
  def index
    render json: { message: 'successful', status: 200 }
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

end
