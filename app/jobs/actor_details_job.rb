class ActorDetailsJob < ApplicationJob
  queue_as :default

  def perform(result)
    json_response = Tmdb.new(ENV["TMDB_KEY"]).get_actor_details(result.json)
    result.update(json: json_response)
  end
end
 