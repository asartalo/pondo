Given(/^I own a ledger$/) do
  user = User.find_by(email: "john.doe@gmail.com")
  puts "USER: #{user.id}"
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

Then(/^I could set the income amount to (\d+)$/) do |arg1|
  fill_in('Amount', with: 500)
end
