# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
symptoms_data = [
  { name: "mood", display_name: "気分" },
  { name: "headache", display_name: "頭痛" },
  { name: "sleep", display_name: "睡眠" },
  { name: "joint_pain", display_name: "関節痛" }
]

symptoms_data.each do |data|
  Symptom.find_or_create_by(name: data[:name]) do |symptom|
    symptom.display_name = data[:display_name]
  end
end
