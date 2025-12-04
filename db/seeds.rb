# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# --- Seed Categories ---
category_data = [
  { name: "Soup", status: "active" },
  { name: "Meat", status: "active" },
  { name: "Sides", status: "active" },
  { name: "Greens", status: "active" },
  { name: "Drinks", status: "active" }
]

puts "Seeding categories..."
categories = {}

category_data.each do |cat|
  record = Category.find_or_create_by!(
    name: cat[:name],
    status: cat[:status],
    created_by: "system",
    updated_by: "system"
  )
  categories[cat[:name]] = record.id
end

puts "Categories seeded."


# --- Seed Menus ---
menu_data = [
  {
    category: "Soup",
    name: "Szechuan Mala",
    description: "Fiery Szechuan-style Mala with bold spices, numbing peppercorns, and rich aromatic heat.",
    price: 158000,
    status: "active"
  },
  {
    category: "Soup",
    name: "Rendang",
    description: "Rich, aromatic Rendang Soup with slow-cooked spices and creamy coconut broth.",
    price: 128000,
    status: "active"
  },
  {
    category: "Meat",
    name: "Daging Ayam",
    description: "Just plain old, daging ayam.",
    price: 45000,
    status: "active"
  },
  {
    category: "Sides",
    name: "Crab Stick",
    description: "This is the best crab stick in HDL.",
    price: 35000,
    status: "active"
  },
  {
    category: "Greens",
    name: "Pak Choi",
    description: "This is the best greens in town.",
    price: 25000,
    status: "active"
  },
  {
    category: "Drinks",
    name: "Liang Teh Wang",
    description: "Most oredered drink in HDL. This is also a must buy.",
    price: 25000,
    status: "active"
  }
]

puts "Seeding menus..."
menus = {}

menu_data.each do |m|
  record = Menu.create!(
    category_id: categories[m[:category]],
    name: m[:name],
    description: m[:description],
    price: m[:price],
    status: m[:status],
    created_by: "testuser1",
    updated_by: ""
  )
  menus[m[:name]] = record.id
end

puts "Menus seeded."
puts "Seeding complete!"

# --- Seed Options ---
options_data = 
[
	{
		menu: "Szechuan Mala",
		name: "Extra Mala Seed",
		description: "Extra Mala Seed for your Fiery Szechuan-style Mala with bold spices, numbing peppercorns, and rich aromatic heat.",
		price: 10000,
		status: "Active",
		created_by: "testuser1",
		updated_by: ""	
	},
	{
		menu: "Liang Teh Wang",
		name: "Extra Sugar",
		description: "Extra sugar for your Liang Teh Wang",
		price: 7500,
		status: "Active",
		created_by: "testuser1",
		updated_by: ""
	},
	{
		menu: "Crab Stick",
		name: "Extra Crab Stick",
		description: "Just plain old, MORE CRAB STICK",
		price: 10000,
		status: "Active",
		created_by: "testuser1",
		updated_by: ""
	},
	{
		menu: "Pak Choi",
		name: "Extra Garlic",
		description: "Extra Garlic for your Pak Choi",
		price: 35000,
		status: "Active",
		created_by: "testuser1",
		updated_by: ""
	}
];

puts "Seeding options..."

options_data.each do |p|
  Option.create!(
    menu_id: menus[p[:menu]],
    name: p[:name],
    description: p[:description],
    price: p[:price],
    status: p[:status],
    created_by: "testuser1",
    updated_by: ""
  )
end

puts "Options seeded."
puts "Seeding complete!"
