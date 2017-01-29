require 'sidekiq'

class AnalyticsWorker
  include Sidekiq::Worker

  def perform(*args)
    puts "LookupWorker#perform fired with arguments #{args.map(&:inspect).join(', ')}"
  end
end
