class Api::V1::UsersController < ApplicationController

  def create
    user = User.create(user_params)
    if user
      jwt = Auth.encrypt({ user_id: user.id })
      render json: { jwt: jwt }
    else
      render json: { error: 'Sign Up has Failed' }, status: 400
    end
  end

  def login
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      jwt = Auth.encrypt({ user_id: user.id })
      render json: { jwt: jwt }
    else
      render json: { error: 'Login has Failed' }, status: 400
    end
  end

  def show
    render json: get_current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
