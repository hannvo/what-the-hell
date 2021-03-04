class CallApiJob < ApplicationJob
  queue_as :default

  def perform(search_id)
    # call API to fetch results for this search
    puts "called successfully"
  end
end
