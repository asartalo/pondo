if Rails.env == 'production'
  Rails.application.middleware.use Rack::Timeout
  Rack::Timeout.service_timeout = 30
end
