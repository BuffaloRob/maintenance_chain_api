class ApplicationController < ActionController::API
  # before_action :authorized
  # include Secured

  def index
    render json: { message: 'successful', status: 200 }
  end

  def auth_header
    request.headers['Authorization']
  end

  def current_user
    if auth_header
      token = auth_header.split(' ')[1]
      auth0_user = JsonWebToken.getUser(token)
      binding.pry
    # auth0_user will be set to 'auth0|5e655656c6dbc90d3de43eb0'
    # Need to add 'auth0_user' string field to schema and find_or_create_by(auth0_user: user) 
      @user = User.find_or_create_by(auth0_user: auth0_user)
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

  # def encode_token(payload)
  #   # secret = Rails.application.credentials.secret_key_base
  #   JWT.encode(payload, 'does this work')
  # end


  # def decoded_token
  #   # secret = Rails.application.credentials.secret_key_base
  #   if auth_header
  #     token = auth_header.split(' ')[1]
  #     begin
  #       JWT.decode(token, 'does this work', true, algorithm: 'HS256')
  #     rescue JWT::DecodeError
  #       nil
  #     end  
  #   end
  # end



  # def token
  #   if request.headers['Authorization'].present?
  #     request.headers['Authorization'].split(' ')[1]

  #   end
  # end
