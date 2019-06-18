class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
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
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
