class Api::V1::ItemsController < ApplicationController
  
  def index
    items = get_current_user.items.all
    binding.pry
    render json: items
  end

  def create
    item = get_current_user.items.build(item_params)
    item.save

    render json: item
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    
    render json: item
  end

  private

  def item_params
    params.require(:item).permit( :name, :user_id )
  end

end
