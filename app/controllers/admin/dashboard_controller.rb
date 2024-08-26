class Admin::DashboardController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :authorize_admin!


  def index
    @cabins = Cabin.all
    @users = User.group_by_day(:created_at).count
    
  end

  private

  def authorize_admin!
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user.admin?
  end

end
