class BookingsController < ApplicationController
  before_action :set_cabin, only: [:new, :create, :edit, :update]
  before_action :set_booking, only: [:destroy]


  
  def calendar
    @cabins = Cabin.all 
  end

  
  def calendar_events
    if params[:cabin_id].present?
      cabin = Cabin.find(params[:cabin_id])
      bookings = cabin.bookings.includes(:user)
    else
      bookings = Booking.includes(:user).all
    end

    events = bookings.map do |booking|
      {
        id: booking.id,
        title: "Booking for #{booking.user.email}",
        start: booking.start_date.to_s,
        end: booking.end_date.to_s
      }
    end

    render json: events
  end

  def user_bookings
  per_page = 10
  page = (params[:page] || 1).to_i
  @bookings = current_user.bookings.order(start_date: :desc).offset((page - 1) * per_page).limit(per_page)
  @total_pages = (current_user.bookings.count.to_f / per_page).ceil
  end

  # Calendar events for the current user's bookings
  def user_calendar_events
    if params[:email].present?
      user = User.find_by(email: params[:email])
      if user
        bookings = user.bookings
      else
        bookings = []
      end
    else
      bookings = []
    end
  
    events = bookings.map do |booking|
      {
        id: booking.id,
        title: "Cabin #{booking.cabin.name}",
        start: booking.start_date.to_s,
        end: booking.end_date.to_s
      }
    end
  
    render json: events
  end
  
  
  def show
    @booking = Booking.find(params[:id])
  
    respond_to do |format|
      format.html # default HTML response
      format.json { render json: @booking.to_json(include: :cabin) }
    end
  end
  
  
  def new
    
    @booking = @cabin.bookings.new
  end

  def create
    @booking = @cabin.bookings.new(booking_params)
    @booking.user = current_user
  
    if dates_available?(@booking.start_date, @booking.end_date)
      if @booking.save
        redirect_to @cabin, notice: 'Booking was successfully created.'
      else
        flash.now[:alert] = "Booking could not be created: #{@booking.errors.full_messages.join(', ')}"
        render :new
      end
    else
      flash.now[:alert] = "Selected dates are already booked."
      render :new
    end
  end
  
  
  

  def edit
    @booking = @cabin.bookings.find(params[:id])
  end

  def update
    @booking = @cabin.bookings.find(params[:id])
    if @booking.update(booking_params)
      redirect_to @cabin, notice: 'Booking was successfully updated.'
    else
      flash.now[:alert] = "Booking could not be updated: #{@booking.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    render json: { message: 'Booking successfully cancelled' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Booking not found' }, status: :not_found
  end

  private
  
  
  def set_booking
    @booking = Booking.find(params[:id])
  end
  
  def set_cabin
    @cabin = Cabin.find(params[:cabin_id])
  end

  
  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price)
  end

 
  def dates_available?(start_date, end_date)
    booked_ranges = @cabin.bookings.pluck(:start_date, :end_date)
    booked_ranges.none? do |range_start, range_end|
      (start_date..end_date).overlaps?(range_start..range_end)
    end
  end
end
