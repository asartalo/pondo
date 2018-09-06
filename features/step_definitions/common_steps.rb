Given(/^I am at the '([^']*)' page$/) do |name|
  step "I visit the '#{name}' page"
end

Given(/^I visit the '([^']*)' page$/) do |name|
  visit pondo_page(name)
  wait_for_page_load
end

Given(/^I own a ledger$/) do
  user = User.find_by(email: "john.doe@gmail.com")
  builder = LedgerBuilder.make(user)
  @owned_ledger = builder.create_ledger(currency: "USD")
end

When(/^I go back$/) do
  page.go_back
end

When(/^I go forward$/) do
  page.go_forward
end

When(/^I reload the page$/) do
  jscript('window.location.reload()')
end

When(/^I pause$/) do
  pause_pls
end

When(/^I wait (\d+) seconds$/) do |duration|
  sleep duration.to_i.seconds
end

Then(/^I should see the '([^']*)' page$/) do |name|
  expect(page).to have_current_path(pondo_page(name))
end

Then(/^I should see '(.+)'$/) do |text|
  expect(page).to have_content(text)
end

Then(/^I should see (.+) ledger page$/) do |ledger_identifier|
  ledger = case ledger_identifier
           when "my owned" then @owned_ledger
           else @ledger
           end
  expect(page).to have_current_path("/ledgers/#{ledger.id}")
end
