class LogsController < ApplicationController
before_filter :authenticate_user!
load_and_authorize_resource
  def index
     @logs = Log.where("project_id = ? and created_at > ?", params[:project_id], Time.at(params[:after].to_i + 1))
  end

  def new
    @log = Log.new
  end

  def create
    @log = Log.new(params[:log])
    if @log.save
      redirect_to @log, 
        :notice => "Successfully created log."
    else
      render :action => 'new'
    end
  end


  def show
    @log = Log.find(params[:id])
  end

  def destroy
    @log = Log.find(params[:id])
    @log.destroy
    redirect_to logs_url, 
      :notice => "Successfully destroyed log."
  end

  def update
    @log = Log.find(params[:id])
    if @log.update_attributes(params[:log])
      redirect_to @log, 
        :notice  => "Successfully updated log."
    else
      render :action => 'edit'
    end
  end

  def edit
    @log = Log.find(params[:id])
  end
end
