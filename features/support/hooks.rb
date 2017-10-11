Before do |scenario|
  # Set test to true and mock the OAuth response
  OmniAuth.config.test_mode = true
end

After do |scenario|
  Capybara.use_default_driver
  OmniAuth.config.mock_auth[:default] = nil
  OmniAuth.config.test_mode = false
  if scenario.failed?
    save_screenshot
  end
end

Around('@email') do |scenario, block|
  ActionMailer::Base.delivery_method = :test
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.deliveries.clear

  old_adapter = ActiveJob::Base.queue_adapter
  ActiveJob::Base.queue_adapter = :inline
  block.call
  ActiveJob::Base.queue_adapter = old_adapter
end

Around('@allow-rescue') do |scenario, block|
  Pondo::Application.config.consider_all_requests_local = false
  block.call
  Pondo::Application.config.consider_all_requests_local = true
end

