source 'https://rubygems.org'
ruby "2.3.1"

def os_is(re)
  RbConfig::CONFIG['host_os'] =~ re
end

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'devise'
gem 'omniauth-google-oauth2'
gem 'slim-rails'
# gem 'bootstrap', '~> 4.0.0.alpha5'
gem 'bourbon'
gem 'neat'
gem 'money'
gem 'coveralls', require: false
gem 'simple_form'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# gem 'therubyracer', platforms: :ruby

group :development, :test do
  gem 'dotenv-rails'
  gem 'byebug', platform: :mri
end

group :development do
  gem 'annotate'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-livereload', require: false
  gem 'guard-cucumber', require: false
  gem 'listen', '~> 3.0.5'
  gem 'rack-livereload'
  gem 'terminal-notifier-guard', platforms: :ruby, install_if: os_is(/darwin/)
  gem 'sextant'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
end

group :test do
  gem 'codeclimate-test-reporter', require: false
  gem 'simplecov', require:  false
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1', require: false
  gem 'api_matchers'
  gem 'rspec-rails'
  gem 'poltergeist'
  gem 'selenium-webdriver'
  gem 'cucumber-rails', require: false
end

group :production do
  gem 'newrelic_rpm'
  gem 'scout_apm'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
