class CastMatcherJob < ApplicationJob
  queue_as :default

  def perform(query)
    @query = query
    if query.count > 1 && (actor_ids = Tmdb.matching_cast(query)) && actor_ids.count > 1
      broadcast({ common_actors: true })
      # if we have 2 movie inputs and several matching actors
      actor_ids.map { |actor_id| Result.create(json: Tmdb.get_actor_details(actor_id)) }
               .each { |actor| broadcast_actor(actor) }
    else
      # if there is only 1 movie input or no matching actors display preresults page
      broadcast({ common_actors: false })
      Tmdb.get_actors(query.last.to_i).each { |actor| broadcast_actor(actor) }
    end
  end

  private

  def render_response(partial, locals)
    ApplicationController.renderer.render_to_string(
      partial: partial,
      locals: { query: @query }.merge(locals)
    )
  end

  def broadcast(response)
    ActionCable.server.broadcast("CastMatcher_result_#{@query.join('&')}", { response: response })
  end

  def broadcast_actor(actor)
    response = render_response("shared/cards/actor_card", { actor: actor })
    broadcast(response)
  end
end
