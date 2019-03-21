class ApplicationController < ActionController::API
  include ::ActionController::Cookies
  
  def index
    render json: { message: 'successful', status: 200 }
  end

  def authenticate_user
    jwt = cookies.signed[:jwt]
    decode_jwt(jwt)
  end

  def get_current_user
    jwt = cookies.signed[:jwt]
    if jwt
      user_info = decode_jwt(jwt)
      user ||= User.find(user_info['user_id'])
    end
    user
  end

end
