($LOAD_PATH << '.' << 'lib' << 'lib/workers').uniq!
require 'analytics_worker'
