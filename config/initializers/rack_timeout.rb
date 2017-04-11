if Rails.env == 'production'
  if defined?(ActionDispatch::RequestId)
    app.config.middleware.insert_after(ActionDispatch::RequestId, Rack::Timeout, service_timeout: 5)
  else
    app.config.middleware.insert_before(Rack::Runtime, Rack::Timeout, service_timeout: 5)
  end
end
