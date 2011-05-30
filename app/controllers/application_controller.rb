class ApplicationController < ActionController::Base
  def log_action(project, user, content)
    Log.create(:user_id => user.id, :project_id => project.id, :content=>content)
  end
  
  private

  def current_ability
    puts "------------------adasdasd---#{session[:project_id]}"
    @current_ability ||= Ability.new(current_user, session[:project_id])
  end
end
