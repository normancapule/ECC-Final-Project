class ProjectsController < ApplicationController
before_filter :authenticate_user!
load_and_authorize_resource

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    @project.user_id = current_user.id
    
    if @project.save
      @userproject = Userproject.create(:user_id=> current_user.id, :project_id => @project.id, :role => "Creator" )
      content = %Q{#{current_user.name} has created the Project #{@project.project_name}}
      log_action(@project, current_user, content)
      
        respond_to do |format| #for ajax
         format.html { #tells the request that it is an html
            redirect_to @project}
            format.js  do
              render :update do |page|
                page << "$('#new_project')[0].reset();"
                page << "$('#projects_table').prepend('#{raw escape_javascript(render @project)}');"
              end
            end
        end
    else
      render :action => 'new'
    end
  end

  def index
    @projects = current_user.projects.find(:all, :order => "created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @project = Project.new
    current_user.traverse_project_id = nil #damn hack
    current_user.save
  end

  def show
    @project = Project.find(params[:id])
    @releases = @project.releases.find(:all, :order => "created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @backlog_list = @project.stories.where(:release_id => nil)
    @release = Release.new
    @logs = @project.logs.order("created_at DESC").limit(5)

    current_user.traverse_project_id = @project.id #damn hack
    current_user.save
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    content = %Q{#{current_user.name} has destroyed the Project #{@project.project_name}}
    log_action(@project, current_user, content)
    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.js   { render :nothing => true }
    end
    current_user.traverse_project_id = nil #damn hack
    current_user.save
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
    content = %Q{#{current_user.name} has updated the Project #{@project.project_name}}
    log_action(@project, current_user, content)
      redirect_to @project, 
        :notice  => "Successfully updated project."
    else
      render :action => 'edit'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end
end
