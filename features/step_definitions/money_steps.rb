Given(/^I own a ledger$/) do
  user = User.find_by(email: "john.doe@gmail.com")
  builder = LedgerBuilder.make(user)
  builder.create_ledger(currency: "USD")
end

When(/^I select the add income section$/) do
  find_link('Add Income').click
  wait_for_ajax
end

Then(/^I should see the add income section$/) do
  expect(page).to have_text("Add Income")
end
