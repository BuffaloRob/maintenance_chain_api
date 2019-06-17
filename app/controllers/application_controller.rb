class ApplicationController < ActionController::API
  
  def index
    render json: { message: 'successful', status: 200 }
  end

  def get_current_user
    token_array = request.headers['HTTP_AUTHORIZATION'].split(" ")
    jwt_token = token_array[1]
    # jwt_token = request.headers['HTTP_AUTHORIZATION']
    if jwt_token
      user_info = Auth.decode(jwt_token)
      user ||= User.find(user_info['user_id'])
    end
    user
  end

end
