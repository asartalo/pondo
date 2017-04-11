Given(/^I own a ledger$/) do
  user = User.find_by(email: "john.doe@gmail.com")
  builder = LedgerBuilder.make(user)
  builder.create_ledger(currency: "USD")
end

When(/^I select the add income section$/) do
  sleep 3
  find_link('Add Income').click
end

Then(/^I should see the add income section$/) do
  expect(page).to have_text("Add Income")
end
