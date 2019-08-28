class PrivateController < ApplicationController
  include Secured

  def hello
    render json: { message: 'you shouldnt see this unless authorized to do so.'}
  end
end
