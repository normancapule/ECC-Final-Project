class ReleasesController < ApplicationController
  def new
    @release = Release.new
  end

  def create
    @release = Release.new(params[:release])
    if @release.save
      redirect_to @release, :notice => "Successfully created release."
    else
      render :action => 'new'
    end
  end

  def index
    @releases = Release.all
  end

  def show
    @release = Release.find(params[:id])
  end

  def destroy
    @release = Release.find(params[:id])
    @release.destroy
    redirect_to releases_url, :notice => "Successfully destroyed release."
  end

  def update
    @release = Release.find(params[:id])
    if @release.update_attributes(params[:release])
      redirect_to @release, :notice  => "Successfully updated release."
    else
      render :action => 'edit'
    end
  end

  def edit
    @release = Release.find(params[:id])
  end
end
