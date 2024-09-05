class Admin::DashboardController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :authorize_admin!


  def index
    @cabins = Cabin.all
    @users = User.group_by_day(:created_at).count
    
    #@income_by_day = Booking.group_by_day(:created_at, format: "%b %d, %Y").sum(:total_price)
    #@income_by_month = Booking.group_by_month(:created_at, format: "%B %Y").sum(:total_price)
    #@bookings_by_cabin = Booking.joins(:cabin).group("cabins.name").count
    #@income_per_cabin = Booking.joins(:cabin).group('cabins.name').sum('bookings.total_price')
     # Total Sales (Revenue)
     @total_sales_today = Booking.where('created_at >= ?', Time.zone.now.beginning_of_day).sum(:total_price)
     @total_sales_week = Booking.where('created_at >= ?', Time.zone.now.beginning_of_week).sum(:total_price)
     
     # Total Bookings
     @total_bookings_today = Booking.where('created_at >= ?', Time.zone.now.beginning_of_day).count
     @total_bookings_week = Booking.where('created_at >= ?', Time.zone.now.beginning_of_week).count
 
     # Current Occupancy Rate
     total_cabins = Cabin.count
     booked_cabins = Booking.where('end_date >= ?', Date.today).distinct.count(:cabin_id)
     @occupancy_rate = (booked_cabins.to_f / total_cabins * 100).round(2)
 
     # Recent Bookings
     @recent_bookings = Booking.order(created_at: :desc).limit(5)
    
  end

  def analytics
    @income_by_day = Booking.group_by_day(:created_at, format: "%b %d, %Y").sum(:total_price)
    @income_by_month = Booking.group_by_month(:created_at, format: "%B %Y").sum(:total_price)
    @bookings_by_cabin = Booking.joins(:cabin).group("cabins.name").count
    @income_per_cabin = Booking.joins(:cabin).group('cabins.name').sum('bookings.total_price')
  end
  
  def users
    @users = User.all
  end
  private

  def authorize_admin!
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user.admin?
  end

end
