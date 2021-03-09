class LwApi
  @face_url = 'https://actorrecognition-tdevy3cs7a-ew.a.run.app/find_actor_by_pic'
  @movie_rec_url = 'https://actorrecognition-tdevy3cs7a-ew.a.run.app/movie_recommender'
  @cloudinary_url = ''

  def self.analyse_image(key)
  end

  def self.recommend_movies(movie_title)
    response = URI.parse(
      @movie_rec_url,
      "movie" => movie_title
    )
  end
end
