class Api::V1::LogsController < ApplicationController
  # GET /logs
  def index
    @category = Category.find_by(id: params[:category_id])
    @logs = @category.logs
    render json: @logs
  end

  # GET /logs/1
  def show
    @log = Log.find(params[:id]) 
    render json: @log
  end

  # POST /logs
  def create
  #   @category = Category.find(params[:category_id])
  #   @last_log = @category.logs.order(date_due: :desc).first
  #   @log = @category.logs.create(log_params)
  #   if @log.save
  #     @last_log.current = false
  #     #@last_log.toggle(:current).save
  #     #@last_log.update(active: false)
  #     @lost_log.save
  #     render json: @log
  #   else
  #     render json: @log.errors
  #   end
  # end
  def create
    @category = Category.find(params[:category_id])
    @log = @category.logs.create(log_params)
    if @log.save
      render json: @log
    else
      render json: @log.errors
    end
  end

  # PATCH/PUT /logs/1
  def update
    category = Category.find_by(id: params[:category_id])
    @log = category.logs.find_by(id: params[:id])
    if @log.update(log_params)
      render json: @log
    else
      render json: @log.errors
    end
  end

  # DELETE /logs/1
  def destroy
    Log.find(params[:id]).destroy
  end

  def past_due
    @all_past_due = []
    @items = get_current_user.items.all
    @items.each do |item|
      item.logs.past_due.current_log.each do |log|
        @all_past_due << log
      end
    end
    render json: @all_past_due

    ####
    # @all_logs = []
    # @last_performed = []
    # @items = get_current_user.items.all
    # @items.each do |item|
    #   item.logs.each do |log|
    #     @all_logs << log
    #   end
    # end
    # @grouped = @all_logs.group_by{ |x| x[:category_id] }
    # @grouped.each do |key, array|
    #   @last_performed << array.first
    # end
    # @last_performed.each |log|
    #   #move log to new array (or reject) if date_due > today
    #   binding.pry
    # end
    #####
    # @all_logs = []
    # @last_performed = []
    # @items = get_current_user.items.all
    # @items.each do |item|
    #   item.logs.past_due.each do |log|
    #     @all_logs << log
    #   end
    # end
    # @grouped = @all_logs.group_by{ |x| x[:category_id] }
    # # logs are default scoped to order by date_due :desc thats why array.first can be used
    # @grouped.each do |key, array|
    #   @last_performed << array.first
    #   # binding.pry
    # end
    # render json: @final_array
    #####
  end

  private
    # Only allow a trusted parameter "white list" through.
    def log_params
      params.require(:log).permit(:notes, :tools, :cost, :date_performed, :date_due, :item_id, :category_id)
    end

end
