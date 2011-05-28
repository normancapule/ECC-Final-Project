class UserprojectsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @userproject = Userproject.new
    @user = User.user
  end

  def create
    
    @project = Project.find(params[:project_id])
    
    params[:user_ids].each do |user_id|
      @userproject = @project.userprojects.new(:user_id => user_id, 
                                               :project_id=> params[:project_id],
                                               :role=> params[:userproject][:role])
      @userproject.save
    end
    if @userproject.save
      redirect_to project_userprojects_path(@project), 
        :notice => "Successfully added member."
    else
      render :action => 'new'
    end
  end

  def index
    @project = Project.find(params[:project_id])
    @userprojects = @project.userprojects
    @user = User.all
  end

  def show
    @project = Project.find(params[:project_id])
    @userproject = @project.userprojects.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:project_id])
    @userproject = @project.userprojects.find params[:id]
    @userproject.destroy
    redirect_to project_userprojects_path(@project), 
      :notice => "Successfully destroyed member."
  end
  
  def update
    @project = Project.find(params[:project_id])
    @userproject = @project.userprojects.find params[:id]
    if @userproject.update_attributes(params[:release])
      redirect_to project_userproject_path(@project, @userproject), 
        :notice  => "Successfully updated member list."
    else
      render :action => 'edit'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @userproject = @project.userprojects.find(params[:id])
    @user = User.all
  end
end
