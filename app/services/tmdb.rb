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
    top_actors = filtered.sort do |b, a|
      a["popularity"] - b["popularity"]
    end

    results = { cast: {},
                movie: {}
              }

    top_actors.first(4).each_with_index do |actor, index|
      results[:cast]["actor#{index+1}".to_sym] = actor
    end

    results
    # @results = { movie: {title: "asda", img: "asdas", date: "1234"},
    #            cast: { actor1: {json.parse}, actor2: {}}
    # }
  end
end
