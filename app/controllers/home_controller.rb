class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :terms ]
  def index
  end

  def terms
  end
end
