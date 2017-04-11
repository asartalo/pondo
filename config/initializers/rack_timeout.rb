if Rails.env == 'production'
  Rack::Timeout.service_timeout = 5
end
