
matt = User.create(name:"matt", email: "matt@gmail.com", password: "password", password_confirmation: "password")

beers = ["Blue Moon", "Guiness", "Lagunitas IPA", "Magic Hat No. 9", "90 min. IPA", "120 min. IPA", "Hell or High Water"]

beers.each do |beer|
  Beer.create(name: beer)
end

Beer.all.sample(3).each do |beer|
  matt.likes << Like.create(beer_id: beer.id)
end
matt.save