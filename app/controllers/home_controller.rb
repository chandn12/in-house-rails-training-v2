class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :terms ]
  def index
    @activities = PublicActivity::Activity.order(created_at: :desc)
    @pagy, @activities = pagy(@activities)
  end

  def terms
  end
end
