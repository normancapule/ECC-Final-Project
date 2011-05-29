class ApplicationController < ActionController::Base
  def log_action(project, user, content)
    Log.create(:user_id => user.id, :project_id => project.id, :content=>content)
  end
end
