class StoriesController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @story = Story.new
    @releases = @project.releases
    @priority_values = ["High", "Medium", "Low"]
  end

  def create
    @project = Project.find(params[:project_id])
    @story = Story.new(params[:story])
    @story.user_id = current_user.id
    @story.priority = params[:priority]
    release = @project.releases.where(:name=>"#{params[:release]}").first
    release.stories << @story
    if @story.save
      redirect_to project_story_path(@project, @story), :notice => "Successfully created story."
    else
      @releases = @project.releases
      @priority_values = ["High", "Medium", "Low"]
      render :action => 'new'
    end
  end

  def index
  end

  def show
    @project = Project.find(params[:project_id])
    @story = Story.find(params[:id])
    @comment = Comment.new
    @comment_list = @story.comments
  end

  def destroy
    @project = Project.find(params[:project_id])
    @story = Story.find(params[:id])
    release = @story.release
    @story.destroy
    redirect_to project_release_path(@project, release), :notice => "Successfully destroyed story."
  end

  def update
    @project = Project.find(params[:project_id])
    @story = Story.find(params[:id])
    @story.priority = params[:priority]
    if @story.update_attributes(params[:story])
      redirect_to project_story_path(@project, @story), :notice  => "Successfully updated story."
    else
      @releases = @project.releases
      @priority_values = ["High", "Medium", "Low"]
      render :action => 'edit'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @story = Story.find(params[:id])
    @releases = @project.releases
    @priority_values = ["High", "Medium", "Low"]
  end
end
