class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    @project.user_id = current_user.id
    
    if @project.save
      @userproject = Userproject.create(:user_id=> current_user.id, :project_id => @project.id, :role => "Creator" )
      redirect_to @project, :notice => "Successfully created project."
    else
      render :action => 'new'
    end
  end

  def index
    @projects = current_user.projects
  end

  def show
    @project = Project.find(params[:id])
    @releases = @project.releases
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_url, :notice => "Successfully destroyed project."
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project, :notice  => "Successfully updated project."
    else
      render :action => 'edit'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end
end
