class Cabin < ApplicationRecord
    has_many_attached :images
    has_many :reviews
    has_many :cabin_views
    
    def average_rating
        return 0 if reviews.empty?
        
        reviews.average(:rating).to_f.round(1)
      end
end
