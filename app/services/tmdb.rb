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

  def get_actor_details(actor_id)
    # takes an actor ID and returns the JSON response
    url = "https://api.themoviedb.org/3/person/#{actor_id}?api_key=#{@api_key}&language=en-US&include_adult=false"
    URI.parse(url).read
  end
end
