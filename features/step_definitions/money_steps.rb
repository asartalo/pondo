When(/^I select the add income section$/) do
  find_link('Add Income').click
  wait_for_remote_request
end

Then(/^I should see the add income section$/) do
  expect(page).to have_text("Add Income")
end

Then(/^I (could ){0,1}set the (income|expense) amount to (\d+)$/) do |_, type, arg1|
  fill_in('Amount', with: 500)
end
