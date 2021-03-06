require 'sidekiq'
require 'telekinesis'

class EventWorker
  include Sidekiq::Worker
  sidekiq_options queue: :nodb, retry: true, backtrace: true

  def perform(event_attributes)

    producer = Telekinesis::Producer::SyncProducer.create(
      stream: 'teleport',
      # failure_handler: MyFailureHandler.new,
      # send_every_ms: 1500,
      endpoint: ENV['AWS_ENDPOINT'],
      credentials: {
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
      }
    )
    result = producer.put(1, event_attributes)
    puts result
  end

end

# class MyFailureHandler
#   def on_record_failure(kv_pairs_and_errors)
#      require "pry"; binding.pry
#     puts kv_pairs_and_errors
#   end
#
#   def on_kinesis_error(err, items)
#      require "pry"; binding.pry
#     puts err.message, items
#   end
#
#   def on_kinesis_retry(err, items)
#      require "pry"; binding.pry
#     puts err.message, items
#   end
#
#   def on_kinesis_failure(err, items)
#      require "pry"; binding.pry
#     puts err.message, items
#   end
# end
