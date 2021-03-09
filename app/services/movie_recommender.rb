require 'open-uri'

class MovieRecommender
  @movie_rec_url = 'https://actorrecognition-tdevy3cs7a-ew.a.run.app/movie_recommender'

  def self.call(movie_title)
    response = URI.parse(
      @movie_rec_url,
      "movie" => movie_title
    )
  end
  
end
