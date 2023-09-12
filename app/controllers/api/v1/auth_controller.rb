class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    binding.pry
    raise params.inspect
    @user = User.find_or_create_by(auth0_user: user_login_params[:auth0_user])
    binding.pry
    if @user
      render json: { user: UserSerializer.new(@user) }, status: :accepted
    else
      render json: { message: 'Invalid email or password' }, status: :unauthorized
    end
  end
  
  # def create
  #   @user = User.find_by(email: user_login_params[:email])
  #   if @user && @user.authenticate(user_login_params[:password])
  #     token = encode_token({ user_id: @user.id })
  #     render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
  #   else
  #     render json: { message: 'Invalid email or password' }, status: :unauthorized
  #   end
  # end

  private

  def user_login_params
    params.require(:user).permit(:email, :auth0_user, :password)
  end

end
