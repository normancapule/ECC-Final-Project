class StoriesController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @story = Story.new
    @releases = @project.releases
  end

  def create
    @project = Project.find(params[:project_id])
    @story = Story.new(params[:story])
    if @story.save
      redirect_to @story, :notice => "Successfully created story."
    else
      render :action => 'new'
    end
  end

  def index
    @project = Project.find(params[:project_id])
    @stories = Story.all
  end

  def show
    @project = Project.find(params[:project_id])
    @story = Story.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:project_id])
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to stories_url, :notice => "Successfully destroyed story."
  end

  def update
    @project = Project.find(params[:project_id])
    @story = Story.find(params[:id])
    if @story.update_attributes(params[:story])
      redirect_to @story, :notice  => "Successfully updated story."
    else
      render :action => 'edit'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @story = Story.find(params[:id])
    @releases = @project.releases
  end
end
