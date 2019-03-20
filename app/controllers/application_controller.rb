class ApplicationController < ActionController::API
  include ::ActionController::Cookies
  
  def index
    render json: { message: 'successful', status: 200 }
  end

  def authenticate_user
    jwt = cookies.signed[:jwt]
    decode_jwt(jwt)
  end

end
