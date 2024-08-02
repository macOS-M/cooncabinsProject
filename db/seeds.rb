# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
5.times do |i|
    cabin = Cabin.create({
        name: "Name",
        description: "description",
        price: 9.99
    })
    cabin.images.attach(io: File.open("db/images/property#{i+1}.jpg"),filename: cabin.name)
    
end