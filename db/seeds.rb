puts "Suppression des anciens mercenaires..."
Mercenary.destroy_all
User.destroy_all  # Supprime aussi les utilisateurs pour éviter les conflits

puts "Création d'un utilisateur..."
user = User.create!(email: "mercenary@example.com", password: "password")

puts "Création de nouveaux mercenaires..."
Mercenary.create!(
  name: "Shadow",
  bio: "Expert en infiltration.",
  photo_url: "https://i.pinimg.com/736x/2f/97/2d/2f972df52223d354c4117f1a854b976f.jpg",
  specialty: "Infiltration",
  price_per_day: 500,
  user: user
)

Mercenary.create!(
  name: "Ghost",
  bio: "Tireur d'élite.",
  photo_url: "https://i.pinimg.com/236x/b8/b6/d9/b8b6d9bbe41785348947e6602e25ca20.jpg",
  specialty: "Sniper",
  price_per_day: 700,
  user: user
)

puts "Mercenaires mis à jour !"

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
