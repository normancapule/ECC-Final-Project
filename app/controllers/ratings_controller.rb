class RatingsController < ApplicationController
load_and_authorize_resource

  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(:story_id => params[:story_id], 
                         :user_id=> current_user.id, 
                         :value => params[:rate])
    if @rating.save
      @story = @rating.story
      @project = @story.project
      content = %Q{#{current_user.name} rated the Story #{@story.story_name} as #{params[:rate]}}
      log_action(@project, current_user, content)
      respond_to do |format|
        format.html { redirect_to(project_story_path(@project,@story)) }
        format.js   { render :nothing => true }
      end
    end
  end

  def index
    @ratings = Rating.all
  end

  def show
    @rating = Rating.find(params[:id])
  end

  def destroy
  end

  def update
  end

  def edit
    @rating = Rating.find(params[:id])
  end
  
 
end
