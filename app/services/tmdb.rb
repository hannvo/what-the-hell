require "open-uri"

class Tmdb
  def initialize(api_key)
    @api_key = api_key
  end

  def get_actors(movie_id)
    url = "https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=#{@api_key}&language=en-US"

    response = open(url).read
    actors = JSON.parse(response)["cast"]
    filtered = actors.select do |actor|
      actor["known_for_department"] == "Acting"
    end
    filtered.sort do |b, a|
      a["popularity"] - b["popularity"]
    end
  end
end
