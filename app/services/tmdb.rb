require "open-uri"

class Tmdb
  def initialize(api_key)
    @api_key = api_key
  end

  def get_actors_and_movie(movie_id)
    actors_url = "https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=#{@api_key}&language=en-US"

    actors_response = open(actors_url).read
    actors = JSON.parse(actors_response)["cast"]
    filtered = actors.select do |actor|
      actor["known_for_department"] == "Acting"
    end
    top_actors = filtered.sort do |b, a|
      a["popularity"] - b["popularity"]
    end

    results = { cast: {},
                movie: {} }

    top_actors.first(4).each_with_index do |actor, index|
      results[:cast]["actor#{index+1}".to_sym] = actor
    end

    movie_details = fetch_movie_details(movie_id)

    results[:movie] = {
      title: movie_details["title"],
      img_path: movie_details["poster_path"],
      year: movie_details["release_date"]
    }
    results
  end

  def fetch_movie_details(movie_id)
    movie_url = "https://api.themoviedb.org/3/movie/#{movie_id}?api_key=#{@api_key}&language=en-US"

    movie_response = open(movie_url).read
    JSON.parse(movie_response)
  end
end
