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
    @over_due = []
    items = current_user.items.all
    categories = items.collect{|item| item.categories}.flatten
    # get the latest log performed for each category
    last_logs = categories.collect{|cat| cat.logs.first}.flatten.compact
    # then check to see if that log is past due. Can't use collect here because it doesn't return the category info on the log needed for the client
    last_logs.each do |log|
      if (log.date_due <= Time.current)
        @over_due << log
      end
    end
    render json: @over_due
  end

  def upcoming
    @future = []
    items = current_user.items.all
    categories = items.collect{|item| item.categories}.flatten
    # get the latest log upcoming for each category
    last_logs = categories.collect{|cat| cat.logs.first}.flatten.compact
    # then check to see if that log is upcoming. Can't use collect here because it doesn't return the category info on the log needed for the client
    last_logs.each do |log|
      if (log.date_due >= Time.current && log.date_due <= Time.current + 30.days)
        @future << log
      end
    end
    render json: @future
  end

  private
    # Only allow a trusted parameter "white list" through.
    def log_params
      params.require(:log).permit(:notes, :tools, :cost, :date_performed, :date_due, :item_id, :category_id)
    end

end
