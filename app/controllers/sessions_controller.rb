class SessionsController < ApplicationController
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
    else
      render json: user.errors
    end
  end

  def destroy
    session[:user_id] = nil
  end

end
