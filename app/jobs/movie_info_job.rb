class MovieInfoJob < ApplicationJob
  queue_as :default

  def perform(query)
    sleep 0.1
    @query = query
    Tmdb.get_movie_details(query).each { |movie| broadcast_movie(movie) }
  end

  private

  def render_response(partial, locals)
    ApplicationController.renderer.render_to_string(
      partial: partial,
      locals: { query: @query }.merge(locals)
    )
  end

  def broadcast(response)
    ActionCable.server.broadcast("MovieInfo_result_#{@query.join('&')}", { response: response })
  end

  def broadcast_movie(movie)
    response = render_response("shared/cards/movie_card", { movie: movie })
    broadcast(response)
  end
end
