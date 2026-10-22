require 'faker'

# Create 10 Genres
10.times.map do
  Genre.create!(
    name: Faker::Book.unique.genre,
  )
end
genres = Genre.all

# Create Users
20.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 8)
  )

  # Create Books
  book = Book.create!(
    name: Faker::Book.unique.title,
    short_description: Faker::Lorem.paragraph(sentence_count: 3),
    user: user
  )

  book.genres << genres.sample(rand(1..3))
end
