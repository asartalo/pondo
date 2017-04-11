require "rack-timeout"
if Rails.env == 'production'
  Rails.application.config.middleware.insert_before Rack::Runtime, Rack::Timeout, service_timeout: 5
end
