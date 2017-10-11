# Change server port
Capybara.app_host = 'http://localhost:3030'
Capybara.server_port = 3030

Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
