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
      render :action => 'new'
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
    @project = Project.find(params[:project_id])
    @story = Story.find(params[:story_id])
    @comment = @story.comments.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to @comment, :notice  => "Successfully updated comment."
    else
      render :action => 'edit'
    end
  end

  def edit
  end
end
