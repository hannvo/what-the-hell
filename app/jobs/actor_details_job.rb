class ActorDetailsJob < ApplicationJob
  queue_as :default

  def perform(result, actor_id)
    result.json = Tmdb.new(ENV["TMDB_KEY"]).get_actor_details(actor_id)
  end
end
