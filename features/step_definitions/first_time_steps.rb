When(/^I choose to create a ledger on the welcome page$/) do
  within find('#first-time') do
    find_link('Create a Ledger').click
  end
end

Then(/^I should see the UI to create my first ledger$/) do
  expect(page).to have_selector('#create-ledger', visible: true)
end

Then(/^I can set my first ledger's name to '([^']*)'$/) do |name|
  find_field('Ledger Name').set(name)
end

Then(/^I can set the currency to '([^']*)'$/) do |currency|
  find_field('Currency').set(currency)
end

Then(/^I can save the ledger$/) do
  find_button('Save Ledger').click
  wait_for_remote_request
  expect(User.first.owned_ledgers.size).to eql(1)
end

Then(/^I should be greeted with a welcome$/) do
  step "I should see 'Welcome to Pondo!'"
end

Then(/^I can see the "([^"]*)" ledger on the header$/) do |name|
  expect(find('.header-title h1').text).to include(name)
end
