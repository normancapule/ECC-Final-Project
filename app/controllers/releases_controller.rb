class ReleasesController < ApplicationController
before_filter :authenticate_user!
load_and_authorize_resource

  def new
    @project = Project.find(params[:project_id])
    @release = @project.releases.new
  end

  def create
    @project = Project.find(params[:project_id])
    @release = @project.releases.build(params[:release])
    if @release.save
      content = %Q{#{current_user.name} has created the Release #{@release.name}}
      log_action(@project, current_user, content)
      
        
        respond_to do |format| #for ajax
         format.html { #tells the request that it is an html
            redirect_to project_path(@project)}
            format.js  do
              render :update do |page|
                page << "$('#new_release')[0].reset();"
                page << "$('#release_table').prepend('#{raw escape_javascript(render @release)}');"  
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
    @release = @project.releases.find(params[:id])
    @stories = @release.stories
  end

  def destroy
    @project = Project.find(params[:project_id])
    @release = @project.releases.find params[:id]
      content = %Q{#{current_user.name} has destroyed the Release #{@release.name}}
      log_action(@project, current_user, content)
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
      content = %Q{#{current_user.name} has updated the Release #{@release.name}}
      log_action(@project, current_user, content)
      redirect_to project_release_path(@project, @release), 
        :notice  => "Successfully updated release."
    else
      render :action => 'edit'
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @release = @project.releases.find(params[:id])
  end
end
