class StoriesController < ApplicationController
before_filter :authenticate_user!
  def new
    @project = Project.find(params[:project_id])
    @story = Story.new
    @releases = @project.releases
    @priority_values = ["High", "Medium", "Low"]
  end

  def create
    @project = Project.find(params[:project_id])
    @story = @project.stories.new(params[:story])
    @story.user_id = current_user.id
    @story.priority = params[:priority]
    release_checker(@story, @project)
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
    @story = @project.stories.find(params[:id])
    if @story.release_id != nil  
      release = @story.release 
    else
      flag = true
    end
    @story.destroy
    if flag == false
      redirect_to project_release_path(@project, release), :notice => "Successfully destroyed story."
    else
      redirect_to project_path(@project), :notice => "Successfully destroyed story."
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @story = @project.stories.find(params[:id])
    @story.priority = params[:priority]
    release_checker(@story, @project)
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
  
  private
    def release_checker(story, project)
      if(params[:release]!= "")
        release = project.releases.where(:name=>"#{params[:release]}").first
        release.stories << story
      else
        story.release_id = nil
      end
    end
end