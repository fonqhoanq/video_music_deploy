50.times {
    User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email(domain: 'example.com'),
      password: Faker::Internet.password,
      age: Faker::Number.between(from: 10, to: 60)
    )
}