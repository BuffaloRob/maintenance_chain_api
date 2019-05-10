class Api::V1::CategoriesController < ApplicationController
  # before_action :set_category, only: [:show, :update, :destroy]

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
    # raise params.inspect
    # @category = Category.new(category_params)
    @item = Item.find(params[:item_id])
    @category = @item.categories.find_or_create_by(category_params)

    if @category.save
      render json: @category#, status: :created, location: @category
    else
      render json: @category.errors#, status: :unprocessable_entity
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
    # if @category.update(category_params)
    #   render json: @category
    # else
    #   render json: @category.errors#, status: :unprocessable_entity
    # end
  end

  # DELETE /categories/1
  def destroy
    Category.find(params[:id]).destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_category
    #   @category = Category.find(params[:id])
    # end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name, :item_id)
    end
end
