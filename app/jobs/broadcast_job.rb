class BroadcastJob < ApplicationJob
  queue_as :default

  def perform(attributes = {})
    @channel = attributes[:channel]
    @query = attributes[:query]
    @partial = attributes[:partial]
    @locals = attributes[:locals]
    @response = attributes[:response] || render_response
    @attr = attributes[:attr]
    broadcast
  end

  private

  def render_response
    ApplicationController.renderer.render_to_string(
      partial: @partial,
      locals: { query: @query }.merge(@locals)
    )
  end

  def broadcast
    ActionCable.server.broadcast("#{@channel}_result_#{@query.join('&')}", { response: @response }.merge((@attr || {})))
  end
end
