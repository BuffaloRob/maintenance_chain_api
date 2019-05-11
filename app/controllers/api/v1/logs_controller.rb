class Api::V1::LogsController < ApplicationController
  # before_action :set_log, only: [:show, :update, :destroy]

  # GET /logs
  def index
    @category = Category.find_by(id: params[:category_id])
    @logs = @category.logs
    render json: @logs
  end

  # GET /logs/1
  def show
    render json: @log
  end

  # POST /logs
  def create
    @item = Item.find(params[:item_id])
    @log = @item.logs.create(log_params)
    if @log.save
      render json: @log#, status: :created, location: @log
    else
      render json: @log.errors#, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /logs/1
  def update
    if params[:category_id]
      item = Item.find_by(id: params[:item_id])
      @log = item.logs.find_by(id: params[:id])
      @log.update(log_params)
      render json: @log
    else
      render json: @log.errors#, status: :unprocessable_entity
    end
  end

  # DELETE /logs/1
  def destroy
    Log.find(params[:id]).destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_log
    #   @log = Log.find(params[:id])
    # end

    # Only allow a trusted parameter "white list" through.
    def log_params
      params.require(:log).permit(:notes, :tools, :cost, :date_performed, :date_due, :item_id, category_attributes: [:name, :id])
    end
end
