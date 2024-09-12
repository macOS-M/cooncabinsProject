require 'faker'

# Clear existing records
Booking.destroy_all
CabinView.destroy_all
Review.destroy_all
User.where.not(admin: true).destroy_all

# Create users
150.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'password123',
    password_confirmation: 'password123',
    created_at: Faker::Date.between(from: '2024-01-01', to: '2024-12-31')
  )
end

# bookings
100.times do
  start_date = Faker::Date.between(from: '2024-01-01', to: '2024-11-30')
  end_date = start_date + rand(1..10).days

  cabin = Cabin.all.sample 
  user = User.order(Arel.sql('RANDOM()')).first 

  Booking.create!(
    cabin: cabin,
    user: user,
    start_date: start_date,
    end_date: end_date,
    total_price: cabin.price * ((end_date - start_date).to_i + 1),
    created_at: Faker::Date.between(from: '2024-01-01', to: '2024-12-31'),
    updated_at: Faker::Date.between(from: '2024-01-01', to: '2024-12-31')
  )
end


# Create random reviews for existing cabins
100.times do
  cabin = Cabin.all.sample
  user = User.order(Arel.sql('RANDOM()')).first
  rating = rand(1..5)

  Review.create!(
    cabin: cabin,
    user: user,
    rating: rating,
    comment: Faker::Lorem.sentence,
    created_at: Faker::Date.between(from: '2024-01-01', to: '2024-12-31'),
    updated_at: Faker::Date.between(from: '2024-01-01', to: '2024-12-31')
  )
end

# Create random cabin views
1000.times do
  cabin = Cabin.all.sample
  user = User.order(Arel.sql('RANDOM()')).first

  CabinView.create!(
    cabin: cabin,
    user: user,
    created_at: Faker::Date.between(from: '2024-8-01', to: '2024-10-01'),
    updated_at: Faker::Date.between(from: '2024-8-01', to: '2024-10-01')
  )
end
