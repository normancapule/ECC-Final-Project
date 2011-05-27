class RatingsController < ApplicationController
  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(:story_id => params[:story_id], :user_id=> current_user.id, :value => params[:rate])
    
    if @rating.save
    
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
    @rating = Rating.find(params[:id])
    @rating.destroy
    redirect_to ratings_url, :notice => "Successfully destroyed rating."
  end

  def update
    @rating = Rating.find(params[:id])
    if @rating.update_attributes(params[:rating])
      redirect_to @rating, :notice  => "Successfully updated rating."
    else
      render :action => 'edit'
    end
  end

  def edit
    @rating = Rating.find(params[:id])
  end
  
 
end
