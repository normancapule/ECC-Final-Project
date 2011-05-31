class HomeController < ApplicationController
before_filter :authenticate_user!
layout 'alternative'
  def index
  end

end
