ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
if ENV['RAILS_ENV'] == 'test'
  puts "Booting in test"
  require 'simplecov'
end

if ENV['PONDO_CYPRESS_RUN']
  puts "FEATURES"
  SimpleCov.command_name "features"
end

require 'bundler/setup' # Set up gems listed in the Gemfile.
