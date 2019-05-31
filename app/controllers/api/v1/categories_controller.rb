class Api::V1::CategoriesController < ApplicationController

  # GET /categories
  def index
    @item = Item.find_by(id: params[:item_id])
    @categories = @item.categories
    render json: @categories
  end

  # GET /categories/1
  def show
    render json: @category
  end

  # POST /categories
  def create
    @item = Item.find(params[:item_id])
    @category = @item.categories.find_or_create_by(category_params)
    if @category.save
      render json: @category
    else
      render json: @category.errors
    end
  end

  # PATCH/PUT /categories/1
  def update
    if params[:item_id]
      item = Item.find_by(id: params[:item_id])
      @category = item.categories.find_by(id: params[:id])
      @category.update(category_params)
      render json: @category
    end
    # else
    #   render json: @category.errors
    # end
  end

  # DELETE /categories/1
  def destroy
    Category.find(params[:id]).destroy
  end

  private
    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name, :item_id)
    end
end
