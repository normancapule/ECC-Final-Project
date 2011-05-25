class UserprojectsController < ApplicationController
  def new
    @userproject = Userproject.new
  end

  def create
    @userproject = Userproject.new(params[:userproject])
    if @userproject.save
      redirect_to @userproject, :notice => "Successfully created userproject."
    else
      render :action => 'new'
    end
  end

  def index
    @userprojects = Userproject.all
  end

  def show
    @userproject = Userproject.find(params[:id])
  end

  def destroy
    @userproject = Userproject.find(params[:id])
    @userproject.destroy
    redirect_to userprojects_url, :notice => "Successfully destroyed userproject."
  end

  def update
    @userproject = Userproject.find(params[:id])
    if @userproject.update_attributes(params[:userproject])
      redirect_to @userproject, :notice  => "Successfully updated userproject."
    else
      render :action => 'edit'
    end
  end

  def edit
    @userproject = Userproject.find(params[:id])
  end
end
