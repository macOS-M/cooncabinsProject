class BookingsController < ApplicationController
    before_action :set_cabin
  
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
            flash[:alert] = "Booking could not be created: #{@booking.errors.full_messages.join(', ')}"
            render :new
          end
        else
          flash[:alert] = "Selected dates are already booked."
          render :new
        end
      end
    
      private
    
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