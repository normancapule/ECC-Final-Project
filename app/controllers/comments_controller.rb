class CommentsController < ApplicationController
  def new
  end

  def create
    @project = Project.find(params[:project_id])
    @story = Story.find(params[:story_id])
    @comment = @story.comments.new(params[:comment])
    if @comment.save
      content = %Q{#{current_user.name} has commented on the Story #{@story.story_name}}
      log_action(@project, current_user, content)
      redirect_to project_story_path(@project,@story), 
        :notice => "Successfully created comment."
    else
      redirect_to project_story_path(@project,@story), 
        :notice => "Comment can't be blank"
    end
  end

  def index
  end

  def show
  end

  def destroy
    @project = Project.find(params[:project_id])
    @story = Story.find(params[:story_id])
    @comment = @story.comments.find(params[:id])
    content = %Q{#{current_user.name} has destroyed the comment 
                #{@comment.comment} on the Story #{@story.story_name}}
    log_action(@project, current_user, content)
    @comment.destroy
    redirect_to project_story_path(@project,@story), 
      :notice => "Successfully destroyed comment."
  end

  def update
  end

  def edit
  end
end
