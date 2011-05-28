class ReleasesController < ApplicationController
before_filter :authenticate_user!
  def new
    @project = Project.find(params[:project_id])
    @release = Release.new
  end

  def create
    @project = Project.find(params[:project_id])
    @release = @project.releases.build(params[:release])
    if @release.save
     # redirect_to project_release_path(@project, @release), :notice => "Successfully created release."
      
        
        respond_to do |format| #for ajax
         format.html { #tells the request that it is an html
            redirect_to project_path(@project)}
            format.js  do
              render :update do |page|
                page << "$('#new_release')[0].reset();"
                page << "$('#release_table').prepend('<tr class=\"odd\"><td>#{ @release.project_id }</td>\
                  <td>#{ @release.name }</td>\
                  <td>#{ @release.date_released }</td>\
                  <td>#{ link_to "Show", project_release_path(@project, @release) }</td>\
                  <td>#{ link_to "Edit", edit_project_release_path(@project, @release) }</td>\
                  <td>#{ link_to "Destroy", project_release_path(@project, @release), :confirm => 'Are you sure?', :method => :delete,  :remote => true, :class=>'delete_post' }</td>\
                  </tr>');"  
              end
            end
        end
     
    else
      render :action => 'new'
    end
  end

  def index
  end

  def show
    @project = Project.find(params[:project_id])
    @release = Release.find(params[:id])
    @stories = @release.stories
  end

  def destroy
    @project = Project.find(params[:project_id])
    @release = @project.releases.find params[:id]
    @release.destroy
   
     respond_to do |format|
      format.html { redirect_to(project_path(@project)) }
      format.js   { render :nothing => true }
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @release = @project.releases.find params[:id]
    
    @release.release_now if params[:release_query] == "yes"
    if @release.update_attributes(params[:release])
      redirect_to project_release_path(@project, @release), :notice  => "Successfully updated release."
    else
      render :action => 'edit'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @release = Release.find(params[:id])
  end
end
