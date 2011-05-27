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
    if(params[:release]!= "")
      release = @project.releases.where(:name=>"#{params[:release]}").first
      release.stories << @story
    else
      @story.release_id = nil
    end
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
    @average = average(@story.id)
    @rated = has_not_rated?
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
    if(params[:release]!= "")
      release = @project.releases.where(:name=>"#{params[:release]}").first
      release.stories << @story
    else
      @story.release_id = nil
    end
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
  
   def average(story_id)
   
     begin
      sum = (Rating.where(:story_id => story_id).sum(:value)).to_f
        count = (Rating.where(:story_id => story_id).count ).to_f
        average = (sum/count).round(1)
      rescue
      average = 0.0
    end
  end
  
  def has_not_rated?
      if Rating.where(:story_id=>@story.id, :user_id=>current_user.id).count == 1
          rated = false
      else
          rated = true
      end
  end
 
end
