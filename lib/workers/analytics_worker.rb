require 'sidekiq'

class AnalyticsWorker
  include Sidekiq::Worker
  sidekiq_options queue: :nodb, retry: true, backtrace: true

  def perform(*args)
    puts "LookupWorker#perform fired with arguments #{args.map(&:inspect).join(', ')}"
  end
end
