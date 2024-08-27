class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :cabin

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  def end_date_after_start_date
    if end_date <= start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  def total_price
    if start_date.present? && end_date.present?
      (end_date - start_date).to_i * cabin.price
    else
      0
    end
  end
  
end
