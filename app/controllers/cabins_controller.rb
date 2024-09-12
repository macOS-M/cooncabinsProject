class CabinsController < ApplicationController
  before_action :set_cabin, only: %i[show edit update destroy create_review]
  before_action :require_admin, only: [:edit, :update, :destroy]
  def index
    @cabins = Cabin.left_joins(:reviews)
      .select("cabins.*, COALESCE(AVG(reviews.rating), 0) AS average_rating")
      .group("cabins.id")

    if params[:min_rating].present?
      @cabins = @cabins.having("AVG(reviews.rating) >= ?", params[:min_rating])
    end
    if params[:max_rating].present?
      @cabins = @cabins.having("AVG(reviews.rating) <= ?", params[:max_rating])
    end

    if params[:min_price].present?
      @cabins = @cabins.where("cabins.price >= ?", params[:min_price])
    end
    if params[:max_price].present?
      @cabins = @cabins.where("cabins.price <= ?", params[:max_price])
    end
  end

  def show
    @review = Review.new
    @booking = @cabin.bookings.new
    CabinView.create(cabin: @cabin, user: current_user)
    @available_dates = calculate_available_dates(@cabin.bookings.pluck(:start_date, :end_date))
    @booked_dates = booked_dates(@cabin.bookings)
  end

  def new
    @cabin = Cabin.new
  end

  def edit
  end

  def create
    @cabin = Cabin.new(cabin_params)

    respond_to do |format|
      if @cabin.save
        format.html { redirect_to cabin_url(@cabin), notice: "Cabin was successfully created." }
        format.json { render :show, status: :created, location: @cabin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cabin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cabin.update(cabin_params)
        format.html { redirect_to @cabin, notice: "Cabin was successfully updated." }
        format.json { render :show, status: :ok, location: @cabin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cabin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cabin.destroy

    respond_to do |format|
      format.html { redirect_to cabins_url, notice: "Cabin was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def create_review
    if @cabin.nil?
      flash[:alert] = "Cabin not found."
      redirect_to cabins_path
      return
    end

    @review = @cabin.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @cabin, notice: "Review submitted successfully."
    else
      flash.now[:alert] = "There was a problem submitting your review."
      render :show
    end
  end

  private

  def set_cabin
    @cabin = Cabin.find(params[:id])
  end

  def cabin_params
    params.require(:cabin).permit(:name, :description, :price, images: [])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def require_admin
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to cabins_path  
    end
  end

  def booked_dates(bookings)
    booked_dates = []
    bookings.each do |booking|
      booked_dates.concat(date_range_to_dates(booking.start_date, booking.end_date))
    end
    booked_dates
  end

  def date_range_to_dates(start_date, end_date)
    return [] if start_date.nil? || end_date.nil? || start_date > end_date
  
    (start_date..end_date).to_a.map { |date| date.strftime('%Y-%m-%d') }
  end
  
  def calculate_available_dates(bookings_dates)
    start_date = Date.today
    end_date = start_date + 6.months
  
    all_dates = (start_date..end_date).to_a.map { |date| date.strftime('%Y-%m-%d') }
  
    available_dates = all_dates - bookings_dates
  
    available_dates
  end
end
