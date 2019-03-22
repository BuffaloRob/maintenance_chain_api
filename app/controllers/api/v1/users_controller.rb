class Api::V1::UsersController < ApplicationController

  # def create
  #   user = User.create(user_params)
  #   if user
  #     jwt = Auth.encrypt({ user_id: user.id })
  #     render json: { jwt: jwt, currentUser: user }
  #   else
  #     render json: { error: 'Sign Up has Failed' }, status: 400
  #   end
  # end

  # def login
  #   user = User.find_by(email: params[:user][:email])
  #   if user && user.authenticate(params[:user][:password])
  #     jwt = Auth.encrypt({ user_id: user.id })
  #     render json: { jwt: jwt, currentUser: user }
  #   else
  #     render json: { error: 'Login has Failed' }, status: 400
  #   end
  # end

  def create
    user = User.create(user_params)
    if user
      # created_jwt = issue_token({ id: user.id })
      created_jwt = Auth.encrypt({ user_id: user.id })
      cookies.signed[:jwt] = { value: created_jwt, httponly: true, expires: 1.hour.from_now }
      # binding.pry
      render json: { currentUser: user }
    else
      render json: { error: 'Sign up has failed' }, status: 400
    end
  end

  def login
    binding.pry
    user = User.find_by(params[:user][:email])
    binding.pry
    if user && user.authenticate(params[:user][:password])
      created_jwt = Auth.encrypt({ user_id: user.id })
      cookies.signed[:jwt] = { value: created_jwt, httponly: true, expires: 1.hour.from_now }
      binding.pry
      render json: { currentUser: user }
    else
      render json: {
        error: 'Username or Password Incorrect'
      }, status: 404
    end 
  end

  def logout
    cookies.delete(:jwt)
  end

  def show
    render json: get_current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
