class ApplicationController < ActionController::API
  before_action :authorized

  def index
    render json: { message: 'successful', status: 200 }
  end

  def encode_token(payload)
    JWT.encode(payload, 'use .env secret')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'use .env secret', true, algorithm: 'HS256')
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
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end

end

  # def get_current_user
  #   token_array = request.headers['HTTP_AUTHORIZATION'].split(" ")
  #   jwt_token = token_array[1]
  #   # jwt_token = request.headers['HTTP_AUTHORIZATION']
  #   if jwt_token
  #     user_info = Auth.decode(jwt_token)
  #     user ||= User.find(user_info['user_id'])
  #   end
  #   user
  # end
# end
