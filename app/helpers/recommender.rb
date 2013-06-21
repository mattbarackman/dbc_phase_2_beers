
helpers do

  def seed_similarity_matrix

    Recommendify.redis = Redis.new

    recommender = BeerRecommender.new

    User.all.each do |user|
      beers = user.beers.map{|beer| beer.id}
      recommender.beer_likes.add_set(user.id, beers)
    end

    recommender.process!

    recommender
  end

  # def find_recommendation(n)
  #   recommender.find(n)
  # end

  def save_likes(beers)
    user = current_user
    beers.each do |beer_id|
      user.likes << Like.find_or_create_by_beer_id(beer_id: beer_id)
    end
    user.save
  end

  # def mode(array)
  #   counts = Hash.new(0)
  #   array.each do |element|
  #     counts[element] += 1
  #   end
  #   array.sort_by{ |element| counts[element] }.last
  # end

  def find_recommendations
    recommender = seed_similarity_matrix
    recommendations = Hash.new { |h, k| h[k] = [] }
    user_beers = current_user.beers
    user_beers.each do |beer|  
      recommender.for(beer.id).each do |neighbor|
        recommendations[neighbor.item_id] << neighbor.similarity unless user_beers.include? Beer.find(neighbor.item_id) 
      end
    end
    save_to_user(recommendations)
  end

  def save_to_user(recommendations)
    user = current_user
    recommendations.each do |beer_id, scores|
      average_score = recommendations[beer_id].inject{ |sum, el| sum + el }.to_f / recommendations.size
      user.recommendations << Recommendation.find_or_create_by_beer_id(beer_id: beer_id, score: average_score) 
    end

  end
end