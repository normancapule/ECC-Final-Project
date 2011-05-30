class SystemUserController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, 
        :notice => "Successfully created a system user."
    else
      render :action => 'new'
    end
  end

  def edit 
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to root_path, 
        :notice => "Successfully updated the user."
    else
      render :action => 'edit'
    end
  end

  def destroy
  end
end
