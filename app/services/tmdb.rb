require "open-uri"

class Tmdb
  @api_key = ENV['TMDB_KEY']

  def self.get_actors(movie_id)
    actors_url = "https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=#{@api_key}&language=en-US"

    actors_response = URI.parse(actors_url).read
    actors = JSON.parse(actors_response)["cast"]
    filtered = actors.select do |actor|
      actor["known_for_department"] == "Acting"
    end
    top_actors = filtered.sort do |b, a|
      a["popularity"] - b["popularity"]
    end

    cast = []
    top_actors.first(4).each { |actor| cast << actor }

    cast
  end

  def self.get_movie_details(array_of_movie_ids)
    movies = []
    array_of_movie_ids.each do |movie_id|
      movie_url = "https://api.themoviedb.org/3/movie/#{movie_id.to_i}?api_key=#{@api_key}&language=en-US"
      movie_response = URI.parse(movie_url).read
      movie_details = JSON.parse(movie_response)

      movies << {
        title: movie_details["title"],
        img_path: movie_details["poster_path"],
        year: movie_details["release_date"]
      }
    end
    # returns array of hashes with movie details
    movies
  end

  def self.get_actor_details(actor_id)
    # takes an actor ID and returns the JSON response
    url = "https://api.themoviedb.org/3/person/#{actor_id}?api_key=#{@api_key}&language=en-US&include_adult=false"
    URI.parse(url).read
  end

  def self.search_actor_name(query)
    query = URI.encode(query)
    url = "https://api.themoviedb.org/3/search/person?api_key=#{@api_key}&language=en-US&query=#{query}&page=1&include_adult=false"
    URI.parse(url).read
  end
end
