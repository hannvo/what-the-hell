require "open-uri"

class Tmdb
  def initialize(api_key)
    @api_key = api_key
  end

  def get_actors(movie_id)
    url = "https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=#{@api_key}&language=en-US"

    response = open(url).read
    JSON.parse(response)
  end
end
