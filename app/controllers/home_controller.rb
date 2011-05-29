class HomeController < ApplicationController
before_filter :authenticate_user!
load_and_authorize_resource

  def index
    set_current_project(nil)
  end

end
