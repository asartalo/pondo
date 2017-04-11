if Rails.env == 'production'
  Rack::Timeout.service_timeout = 30
end
