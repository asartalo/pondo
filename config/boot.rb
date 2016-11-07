ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  SimpleCov.start 'rails'
end

require 'bundler/setup' # Set up gems listed in the Gemfile.
