class ReleasesController < ApplicationController
before_filter :authenticate_user!
  def new
    @project = Project.find(params[:project_id])
    @release = @project.releases.new
  end

  def create
    @project = Project.find(params[:project_id])
    @release = @project.releases.build(params[:release])
    if @release.save
      redirect_to project_release_path(@project, @release), 
        :notice => "Successfully created release."
    else
      render :action => 'new'
    end
  end

  def index
  end

  def show
    @project = Project.find(params[:project_id])
    @release = @project.releases.find(params[:id])
    @stories = @release.stories
  end

  def destroy
    @project = Project.find(params[:project_id])
    @release = @project.releases.find params[:id]
    @release.destroy
    redirect_to project_path(@project), 
      :notice => "Successfully destroyed release."
  end

  def update
    @project = Project.find(params[:project_id])
    @release = @project.releases.find params[:id]
    @release.release_now if params[:release_query] == "yes"
    if @release.update_attributes(params[:release])
      redirect_to project_release_path(@project, @release), 
        :notice  => "Successfully updated release."
    else
      render :action => 'edit'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @release = @project.releases.find(params[:id])
  end
end
