require 'faker'

User.destroy_all
Event.destroy_all
Attendance.destroy_all

# Création de quelques utilisateurs avec des adresses @yopmail.com
5.times do
  user = User.create!(
    email: Faker::Internet.email(domain: 'yopmail.com'),
    encrypted_password: Faker::Internet.password,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )

  # Création de quelques événements pour chaque utilisateur
  3.times do
    event = Event.create!(
      admin: user, # Utilisateur associé à l'événement
      start_date: Faker::Time.forward(days: 30, period: :morning),
      duration: rand(1..6) * 5, # Durée aléatoire en multiples de 5
      title: Faker::Lorem.sentence(word_count: 3),
      description: Faker::Lorem.paragraph(sentence_count: 3),
      price: rand(1..1000),
      location: Faker::Address.city
    )

    # Création de participations pour chaque événement
    rand(1..5).times do
      Attendance.create!(
        stripe_customer_id: Faker::Alphanumeric.alphanumeric(number: 10),
        user: User.all.sample,
        event: event
      )
    end
  end
end

puts "Utilisateurs, événements et participations créés avec succès !"
