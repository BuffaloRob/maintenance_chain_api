class Api::V1::AuthController < ApplicationController

  def create
    user = User.find_by(params[:email])
    if user && user.authenticate(params[:password])
      created_jwt = issue_token({id: user.id})
      cookies.signed[:jwt] = {value: created_jwt, httponly: true, expires: 1.hour.from_now}
      render json: {username: user.username}
    else
      render json: {
        error: 'Username or Password Incorrect'
      }, status: 404
    end 
  end

  private

  # def auth_params
  #   params.require(:auth).permit(:email, :password)
  # end

end
