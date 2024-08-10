class Cabin < ApplicationRecord
    has_many_attached :images
    has_many :reviews

    def average_rating
        return 0 if reviews.empty?
        
        reviews.average(:rating).to_f
      end
end
