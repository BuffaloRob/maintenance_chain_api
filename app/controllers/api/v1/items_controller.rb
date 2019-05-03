class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:update, :destroy, :show]

  def index
    @items = get_current_user.items.all
    # binding.pry
    render json: @items
  end

  def create
    @item = get_current_user.items.build(item_params)

    if @item.save
      # binding.pry
      render json: @item
    else
      render json: @item.errors
    end
  end

  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors
    end
  end

  def show
    # binding.pry
    render json: @item
  end

  def destroy
    @item.destroy
    # render json: @item
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit( :name, :user_id )
  end

end
