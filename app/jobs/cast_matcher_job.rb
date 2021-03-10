class CastMatcherJob < ApplicationJob
  queue_as :default

  def perform(query)
    if query.count > 1 && (actor_ids = Tmdb.matching_cast(query)) && actor_ids.count > 1
      # if we have 2 movie inputs and several matching actors
      cast = actor_ids.map { |actor_id| Result.create(json: Tmdb.get_actor_details(actor_id)) }
      common_actors = true
    else
      # if there is only 1 movie input or no matching actors display preresults page
      cast = Tmdb.get_actors(query.last.to_i)
      common_actors = false
    end
    response = ApplicationController.renderer.render_to_string(
      partial: "shared/views/cast_section",
      locals: { queries: query.split('&'), cast: cast, common_actors: common_actors }
    )
    #ActionCable.server.broadcast("CastMatcher_result_#{query.join('&')}", { response: response })
  end
end
