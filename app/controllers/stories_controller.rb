class StoriesController < ApplicationController
before_filter :authenticate_user!
load_and_authorize_resource

  def new
    @project = Project.find(params[:project_id])
    @story = @project.stories.new
    @releases = @project.releases
    @priority_values = ["High", "Medium", "Low"]
    @status_values = ["Start", "Finish", "Hold", "Reject", "Accept"]
  end

  def create
    @project = Project.find(params[:project_id])
    @story = @project.stories.new(params[:story])
    @story.user_id = current_user.id
    release_checker(@story, @project)
    if @story.save
      content = %Q{#{current_user.name} has created the Story #{@story.story_name}}
      log_action(@project, current_user, content)
      tag_control(params[:tags], @story, @project)
      redirect_to project_story_path(@project, @story), 
        :notice => "Successfully created story."
    else
      @releases = @project.releases
      @priority_values = ["High", "Medium", "Low"]
      @status_values = ["Start", "Finish", "Hold", "Reject", "Accept"]
      render :action => 'new'
    end
  end

  def index
  end

  def show
    @project = Project.find(params[:project_id])
    @story = @project.stories.find(params[:id])
    @comment = @story.comments.new
    @comment_list = @story.comments
    @average = average(@story.id)
    @rated = has_not_rated?
    @tags = display_story_tags(@story)
  end

  def destroy
    @project = Project.find(params[:project_id])
    @story = @project.stories.find(params[:id])
    if @story.release_id != nil  
      release = @story.release 
    else
      flag = true
    end
    content = %Q{#{current_user.name} has destroyed the Story #{@story.story_name}}
    log_action(@project, current_user, content)
    @story.destroy
    if flag == false
      redirect_to project_release_path(@project, release), 
        :notice => "Successfully destroyed story."
    else
      redirect_to project_path(@project), 
        :notice => "Successfully destroyed story."
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @story = @project.stories.find(params[:id])
    release_checker(@story, @project)
    if @story.update_attributes(params[:story])
      content = %Q{#{current_user.name} has updated the Story #{@story.story_name}}
      log_action(@project, current_user, content)
      redirect_to project_story_path(@project, @story), 
        :notice  => "Successfully updated story"
    else
      @releases = @project.releases
      @priority_values = ["High", "Medium", "Low"]
      render :action => 'edit'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @story = @project.stories.find(params[:id])
    @releases = @project.releases
    @priority_values = ["High", "Medium", "Low"]
    @status_values = ["Start", "Finish", "Hold", "Reject", "Accept"]
    @tags = display_story_tags(@story)
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
    
    def tag_control(param, story, project)
      tags = param.gsub(/[\s]/, "").downcase.split(",")
      errors = ""
      Tag.where(:story_id=>story.id, :project_id=>project.id).delete_all
      tags.each do |tag|
        Tag.create(:story_id=>story.id, :content=>tag, :project_id=>project.id)
      end
    end
    
    def display_story_tags(story)
      content = ""
      story.tags.each do |tag|
        content << tag.content + ","
      end
        content.chop!
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

