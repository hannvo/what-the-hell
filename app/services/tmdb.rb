require "open-uri"

class Tmdb
  @api_key = ENV['TMDB_KEY']

  def self.get_actors(movie_id)
    filtered = api_call_for_actors(movie_id)

    top_actors = filtered.sort do |b, a|
      a["popularity"] - b["popularity"]
    end

    cast = []
    top_actors.first(4).each { |actor| cast << Result.create(json: actor.to_json) }

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

  def self.matching_cast(array_of_movie_ids)
    # get cast to have 2 arrays with [ actor, actor, actr, ...]
    # arr-o-m-i ["1232", '1232']
    first_movie_id = array_of_movie_ids.first
    first_movie_actors_ids = api_call_for_actors(first_movie_id.to_i).map { |actor| actor["id"] }

    return first_movie_actors_ids if array_of_movie_ids.one?

    second_movie_id = array_of_movie_ids[1]
    second_movie_actors_ids = api_call_for_actors(second_movie_id.to_i).map { |actor| actor["id"] }

    first_movie_actors_ids & second_movie_actors_ids
  end

  def self.get_actor_details(actor_id)
    actor_id = actor_id.to_s if actor_id.is_a? Integer
    # takes an actor ID and returns the JSON response
    url = "https://api.themoviedb.org/3/person/#{actor_id}?api_key=#{@api_key}&language=en-US&include_adult=false"
    begin
      URI.parse(url).read
    rescue
      self.actor_not_found
    end
  end

  def self.api_call_for_actors(movie_id)
    actors_url = "https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=#{@api_key}&language=en-US"

    actors_response = URI.parse(actors_url).read
    actors = JSON.parse(actors_response)["cast"]
    actors.select do |actor|
      actor["known_for_department"] == "Acting"
    end
  end

  def self.actor_not_found
    "{\"adult\":\"\",\"also_known_as\":\"\",\"biography\":\"\",\"birthday\":\"\",\"deathday\":\"\",\"gender\":\"\",\"homepage\":\"\",\"id\":\"\",\"imdb_id\":\"\",\"known_for_department\":\"\",\"name\":\"NOT FOUND\",\"place_of_birth\":\"\",\"popularity\":\"\",\"profile_path\":\"\"}"
  end

  def self.search_actor_name(query)
    query = URI.encode(query)
    url = "https://api.themoviedb.org/3/search/person?api_key=#{@api_key}&language=en-US&query=#{query}&page=1&include_adult=false"
    actor_id = JSON.parse(URI.parse(url).read)['results'][0]['id']
    self.get_actor_details(actor_id)
  end

  def self.movie_details_recom(hash_with_movie_names)
    movies = []
    hash_with_movie_names.first(3).each do |_key, movie|
      url = "https://api.themoviedb.org/3/search/movie?api_key=#{@api_key}&query=#{movie}"
      response = URI.parse(url).read
      movie_details = JSON.parse(response)['results'].first
      movies << {
        title: movie_details["title"],
        img_path: movie_details["poster_path"],
        description: movie_details["overview"],
        year: movie_details["release_date"]
      }
    end
    movies
  end
end
