source 'https://rubygems.org'
ruby "2.3.7"

def os_is(re)
  RbConfig::CONFIG['host_os'] =~ re
end

gem 'rails', '~> 5.2.4', '>= 5.2.4.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.12', '>= 3.12.6'
gem 'sass-rails', '~> 5.0', '>= 5.0.6'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2', '>= 4.2.2'
gem 'jquery-rails', '>= 4.3.1'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
# gem 'devise'
gem 'devise', git: 'https://github.com/plataformatec/devise.git', branch: 'master'
gem 'omniauth-google-oauth2', '0.5.0'
gem 'slim-rails', git: 'https://github.com/yasaichi/slim-rails.git', branch: 'pass-context-object-to-render'
# gem 'bootstrap', '~> 4.0.0.alpha5'
gem 'bourbon'
gem 'neat'
gem 'money'
gem 'coveralls', '>= 0.8.19', require: false
# gem 'simple_form'
gem 'simple_form', git: 'https://github.com/elsurudo/simple_form.git', branch: 'rails-5.1.0'
gem 'typhoeus'
gem 'restcountry', '>= 0.5.2'
gem 'sidekiq'
gem "sidekiq-cron", "~> 0.4.0"
gem 'bcrypt'
gem 'dalli'
gem 'gakubuchi', '>= 1.4.0'
gem 'webpacker', '~> 3.5', '>= 3.5.5'
gem "nitrolinks-rails", ">= 0.3.0"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# gem 'therubyracer', platforms: :ruby

group :development, :test do
  gem 'dotenv-rails', '>= 2.2.2'
  gem 'byebug', platform: :mri
  gem 'nokogiri', '~> 1.8.1'
  gem 'jasmine-rails', '>= 0.14.2'
  gem 'cypress-on-rails', '~> 1.0'
end

group :development do
  gem 'annotate'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-livereload', require: false
  gem 'listen', '~> 3.0.5'
  gem 'rack-livereload'
  gem 'terminal-notifier-guard', platforms: :ruby, install_if: os_is(/darwin/)
  gem 'sextant', git: 'https://github.com/mpakus/sextant.git'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.5.1'
end

group :test do
  gem 'codeclimate-test-reporter', '>= 1.0.8', require: false
  gem 'simplecov', '>= 0.12.0', require:  false
  gem 'factory_bot_rails', '>= 4.11.1'
  gem 'database_cleaner'
  gem 'api_matchers', '>= 0.6.2'
  gem 'rspec-rails', '>= 3.6.1'
  gem 'shoulda-matchers'
end

group :production do
  gem 'newrelic_rpm'
  gem 'scout_apm'
  gem 'rack-timeout'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
