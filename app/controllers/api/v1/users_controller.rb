class Api::V1::UsersController < ApplicationController

  def create
    user = User.create(user_params)
    if user
      jwt = Auth.encrypt({ user_id: user.id })
      render json: { jwt: jwt, current: user }
    else
      render json: { error: 'Sign Up has Failed' }, status: 400
  end

  def login
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:email])
      jwt = Auth.encrypt({ user_id: user.id })
      render json: { jwt: jwt, current: user }
    else
      render json: { error: 'Login has Failed' }, status: 400
    end
  end

  def show
    render json: get_current_userr
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
