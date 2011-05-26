class ReleasesController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @release = Release.new
  end

  def create
    @project = Project.find(params[:project_id])
    @release = @project.releases.build(params[:release])
    if @release.save
      redirect_to project_releases_path(@project), :notice => "Successfully created release."
    else
      render :action => 'new'
    end
  end

  def index
    @project = Project.find(params[:project_id])
    @releases = Release.all
  end

  def show
    @project = Project.find(params[:project_id])
    @release = Release.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:project_id])
    @release = @project.releases.find params[:id]
    @release.destroy
    redirect_to project_releases_path(@project), :notice => "Successfully destroyed release."
  end

  def update
    @project = Project.find(params[:project_id])
    @release = @project.releases.find params[:id]
    if @release.update_attributes(params[:release])
      redirect_to project_release_path(@project, @release), :notice  => "Successfully updated release."
    else
      render :action => 'edit'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @release = Release.find(params[:id])
  end
end
