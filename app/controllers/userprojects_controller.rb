class UserprojectsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @userproject = Userproject.new
    @user = User.user
  end

  def create
    
    @project = Project.find(params[:project_id])
    
    begin
    params[:user_roles].each do |user_roles|
      params[:user_ids].each do |user_id|
        @userproject = Userproject.new(:user_id => user_id, 
                                       :project_id=> params[:project_id], 
                                       :role=> user_roles)
                
      @userproject.save
      content = %Q{#{current_user.name} added #{User.find(user_id).name} to project #{@project.project_name} as #{user_roles}}
      log_action(@project, current_user, content)
      end
    end

      redirect_to project_userprojects_path(@project), 
        :notice => "Successfully added member."

    rescue
       redirect_to new_project_userproject_path(@project),
       :alert => "Please select both member and role."
    end
    
  end

  def index
    @project = Project.find(params[:project_id])
    @userprojects = @project.userprojects.select("DISTINCT ON (user_id) *")
    @user = User.all
  end

  def show
    @project = Project.find(params[:project_id])
    @userproject = Userproject.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:project_id])
    @userproject = @project.userprojects.find params[:id]
    @user = @userproject.user_id
    @userprojects =  Userproject.where(:user_id => @user, :project_id => @project.id).delete_all
    
    redirect_to project_userprojects_path(@project), 
      :notice => "Successfully destroyed member."
  end
  
  def update
  
    @project = Project.find(params[:project_id])
    @userproject = @project.userprojects.find params[:id]
    @user = @userproject.user_id
    @userprojects =  Userproject.where(:user_id => @user, :project_id => @project.id).delete_all
    
    
    params[:user_roles].each do |user_roles|
      @userproject = Userproject.new(:user_id => @user, 
                                     :project_id=> params[:project_id], 
                                     :role=> user_roles)
      @userproject.save
    end
    if @userproject.save
      redirect_to project_userprojects_path(@project), 
        :notice => "Successfully udated member."
    else
      render :action => 'new'
    end

  end

  def edit
    @project = Project.find(params[:project_id])
    @userproject =  Userproject.find(params[:id])
    @user = @userproject.user_id
    @userprojects =  Userproject.where(:user_id => @user, :project_id => @project.id).map(&:role).join(', ')
    
  end
end
