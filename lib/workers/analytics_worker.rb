require 'sidekiq'
require 'telekinesis'

class AnalyticsWorker
  include Sidekiq::Worker
  sidekiq_options queue: :nodb, retry: true, backtrace: true

  def perform(*args)
    require 'telekinesis'

    producer = Telekinesis::Producer::AsyncProducer.create(
      stream: 'teleport',
      failure_handler: MyFailureHandler.new,
      send_every_ms: 1500,
      credentials: {
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
      }
    )
    producer.put(1, args.join(','))
  end

end

class MyFailureHandler
  def on_record_failure(kv_pairs_and_errors)
    puts kv_pairs_and_errors
  end

  def on_kinesis_error(err, items)
    puts err, items
  end

  def on_kinesis_retry(err, items)
    puts err, items
  end

  def on_kinesis_failure(err, items)
    puts err, items
  end
end
