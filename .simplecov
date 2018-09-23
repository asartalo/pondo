require 'coveralls'

if ENV['PONDO_CYPRESS_RUN']
  puts "FEATURES"
  SimpleCov.command_name "features"
end

Coveralls.wear_merged! 'rails'
