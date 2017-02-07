($LOAD_PATH << '.' << 'lib' << 'lib/workers').uniq!
require 'event_worker'


Sidekiq.configure_server do |config|
  config.redis = { namespace: ENV['REDIS_NAMESPACE'] } if ENV['REDIS_NAMESPACE']
end

