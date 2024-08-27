class Cabin < ApplicationRecord
    has_many_attached :images
    has_many :reviews
    has_many :cabin_views
    has_many :bookings
    after_save :update_available_dates
    
    def average_rating
        return 0 if reviews.empty?
        
        reviews.average(:rating).to_f.round(1)
      end

      def calculate_available_dates(booked_ranges)
        return [] if booked_ranges.empty?
    
        all_dates = []
        booked_ranges.each do |start_date, end_date|
          all_dates.concat((start_date..end_date).to_a)
        end
    
        # Define the range of dates you want to consider (e.g., the next 6 months)
        start_range = Date.today
        end_range = start_range + 6.months
    
        available_dates = (start_range..end_range).to_a - all_dates.uniq
        available_dates
      end
      private

      def update_available_dates
        booked_ranges = bookings.pluck(:start_date, :end_date)
        self.available_dates = calculate_available_dates(booked_ranges)
        save if saved_change_to_available_dates?
      end
    
      
end
