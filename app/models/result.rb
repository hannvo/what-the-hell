class Result < ApplicationRecord
  # after_commit :async_update
  after_commit :fetch_json

  private

  def fetch_json
    init_json = JSON.parse(json)
    return unless init_json['actor_id']

    self.json = Tmdb.new(ENV["TMDB_KEY"]).get_actor_details(init_json['actor_id'])
  end

  def async_update
    init_json = JSON.parse(json)
    return unless init_json['actor_id']

    ActorDetailsJob.perform_later(self, init_json['actor_id'])
  end
end
