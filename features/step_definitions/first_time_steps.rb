Then(/^I should see the UI to create my first ledger$/) do
  steps "Then I should see 'Create Your First Ledger'"
end

Then(/^I can set my first ledger's name to '([^']*)'$/) do |name|
  find_field('Ledger Name').set(name)
end

Then(/^I can set the currency to '([^']*)'$/) do |currency|
  find_field('Currency').set(currency)
end

Then(/^I can save the ledger$/) do
  find_button('Create Ledger').click
  wait_for_ajax
  expect(User.first.owned_ledgers.size).to eql(1)
end

Then(/^I should be greeted with a welcome$/) do
  step "I should see 'Welcome to Pondo!'"
end
