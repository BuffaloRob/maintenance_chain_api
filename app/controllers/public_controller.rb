class PublicController < ApplicationController
  def hello
    render json: { message: 'Hello from public endpoint, no auth needed here.' }
  end
end
