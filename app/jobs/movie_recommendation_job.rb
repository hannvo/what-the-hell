class MovieRecommendationJob < ApplicationJob
  queue_as :default

  def perform(movie, query)
    recommendations = MovieRecommendation.get_movie_names(movie)
    return if recommendations["ERROR"]

    sleep 0.25
    BroadcastJob.perform_now(
      { channel: "MovieRecommendation",
        query: query,
        partial: "shared/cards/movie_reco",
        locals:
        { recommendations: Tmdb.movie_details_recom(recommendations),
          base_movie: movie } }
    )
  end
end
