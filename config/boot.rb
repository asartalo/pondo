ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
if ENV['RAILS_ENV'] == 'test'
  puts "Booting in test"
  require 'simplecov'
end

require 'bundler/setup' # Set up gems listed in the Gemfile.
