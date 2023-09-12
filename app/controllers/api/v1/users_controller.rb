class Api::V1::UsersController < ApplicationController
  # skip_before_action :authorized, only: [:create]

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  def create
    if auth_header
      token = auth_header.split(' ')[1]
      auth0 = JsonWebToken.getUser(token)
      @user = User.find_or_create_by(auth0_user: auth0)
    end
    if @user.valid?
      # @token = encode_token(user_id: @user.id)
      # render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
      binding.pry
      #TODO: fix 'Rendered ActiveModel::Serializer::Null with Hash'
      render json: { user: UserSerializer.new(@user) }, status: :created
    else
      render json: { error: 'Sign Up has Failed' }, status: :not_acceptable
    end
  end

  def logout
    # binding.pry
    # render json: { jwt: jwt }
  end
  
  private

  def user_params
    params.require(:user).permit(:auth0_user)
    # params.require(:user).permit(:email, :auth0_user, :password, :password_confirmation)
  end

end
