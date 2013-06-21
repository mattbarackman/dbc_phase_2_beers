Recommendify.redis = Redis.new

recommender = BeerRecommender.new

# add `order_id->product_id` interactions to the order_item_sim input
# you can add data incrementally and call RecommendedItem.process! to update
# the similarity matrix at any time.
# 
User.all.each do |user|
  beers = user.beers.map{|beer| beer.id}
  recommender.beer_likes.add_set(user.id, beers)
end

# Calculate all elements of the similarity matrix
recommender.process!

# retrieve similar products to "product23"


recommender.for(1) 