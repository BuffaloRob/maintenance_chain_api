class ApplicationController < ActionController::API
  include ::ActionController::Cookies
  
  def index
    render json: { message: 'successful', status: 200 }
  end

  def authenticate_user
    jwt = cookies.signed[:jwt]
    Auth.decode(jwt)
  end

  def get_current_user
    jwt = cookies.signed[:jwt]
    if jwt
      user_info = Auth.decode(jwt)
      user ||= User.find(user_info['user_id'])
    end
    user
  end

end
