# Users
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
              email: email,
              password:              password,
              password_confirmation: password)
end

# Events
users = User.order(:created_at).take(6)
10.times do
  title = Faker::Lorem.word
  description = Faker::Lorem.sentence(5)
  location = Faker::Address.city
  date = Faker::Date.between(2.days.ago, Date.today)
  users.each { |user| user.events.create!(location: location,
                                           description: description,
                                           title: title,
                                           date: date) }
end

# Adding invites
users = User.all
event = Event.order(:created_at).take(5)
going = users[2..20]
going.each { |attendee| attendee.go(event) }
