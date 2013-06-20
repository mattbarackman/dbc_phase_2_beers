beers = ["Corona", "Pacifico", "Sol", "Magic Hat No. 9", "90 min. IPA", "120 min. IPA", "Lagunitas IPA"]

beers.each do |beer|
  Beer.create(name: beer)
end

light_beers = Beer.first(3)

5.times do 
  name = "#{Faker::Name.first_name} #{Faker::Name.last_name}"
  user = User.create(name: name , email: Faker::Internet.email(name), password: "password", password_confirmation: "password")
  light_beers.each do |beer|
    user.likes << Like.create(beer_id: beer.id)
  end 
  user.save
end

ipas = Beer.last(3)

5.times do 
  name = "#{Faker::Name.first_name} #{Faker::Name.last_name}"
  user = User.create(name: name , email: Faker::Internet.email(name), password: "password", password_confirmation: "password")
  ipas.each do |beer|
    user.likes << Like.create(beer_id: beer.id)
  end 
  user.save
end

matt_ipa = User.create(name:"matt", email: "matt@gmail.com", password: "password", password_confirmation: "password")
matt_ipa.likes << Like.create(beer_id: 5)
matt_ipa.likes << Like.create(beer_id: 6)
matt_ipa.save

bob_mexican = User.create(name:"bob", email: "bob@gmail.com", password: "password", password_confirmation: "password")
bob_mexican.likes << Like.create(beer_id: 1)
bob_mexican.likes << Like.create(beer_id: 2)
bob_mexican.save