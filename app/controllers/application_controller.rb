class ApplicationController < ActionController::Base

  def log_action(project, user, content)
    log = Log.create(:user_id => user.id, :project_id => project.id, :content=>content)
    log.user = user
    log.project = project
    log.content = content
    log.save
  end
end
