class ApplicationController < ActionController::API
  before_action :authorized

  def index
    render json: { message: 'successful', status: 200 }
  end

  def encode_token(payload)
    secret = Rails.application.credentials.secret_key_base
    JWT.encode(payload, 'does this work')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    secret = Rails.application.credentials.secret_key_base
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'does this work', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end  
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render status: :unauthorized unless logged_in?
    # The message below was causing a blank item object to render in the ItemList due to redux persist
    # render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end

end