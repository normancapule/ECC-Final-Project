class CommentsController < ApplicationController
  def new
  end

  def create
    @project = Project.find(params[:project_id])
    @story = Story.find(params[:story_id])
    @comment = @story.comments.new(params[:comment])
    if @comment.save
      redirect_to project_story_path(@project,@story), :notice => "Successfully created comment."
    else
      redirect_to project_story_path(@project,@story), :notice => "Comment can't be blank"
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
    @comment.destroy
    redirect_to project_story_path(@project,@story), :notice => "Successfully destroyed comment."
  end

  def update
  end

  def edit
  end
end
