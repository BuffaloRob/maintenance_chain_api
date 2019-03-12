class Api::V1::ItemsController < ApplicationController
  
  def index
    items = get_current_user.items.all

    render json: items
  end

  def create
    item = get_current_user.items.build(item_params)
    item.save

    render json: item
  end

  def destroy
    item = Todo.find(params[:id])
    item.destroy
    
    render json: item
  end

  private

  def item_params
    params.require(:item).permit( :name )
  end

end
