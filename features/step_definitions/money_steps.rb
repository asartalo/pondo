When(/^I set the (income source) to "([^"]*)"$/) do |kind, type|
  @income_type = type
  within ('#add-income-section') do
    select type, from: "Source"
  end
end


When(/^I set the (income|expense) date to ([\d\/]+)$/) do |kind, date|
  @income_date = Date.parse(date)
  within ('#add-income-section') do
    fill_in "Date", with: date
  end
end

When(/^I add an (income|expense) note to say "([^"]*)"$/) do |kind, note|
  @income_note = note
  within ('#add-income-section') do
    fill_in "Notes", with: note
  end
end

When(/^I submit the income$/) do
  within ('#add-income-section') do
    click_button "Add Income"
  end
end

When(/^I select the add income section$/) do
  find_link('Add Income').click
  wait_for_remote_request
end

Then(/^I should see the add income section$/) do
  expect(page).to have_text("Add Income")
end

Then(/^I (could ){0,1}set the (income|expense) amount to (\d+)$/) do |_, type, amount|
  @amount = amount
  within ('#add-income-section') do
    fill_in('Amount', with: amount)
  end
end

Then(/^I should see the (income|expense) added to (my own) ledger$/) do |kind, the_ledger|
  expect(find('#money-moves').text).to include(@amount)
  move_type = IncomeType.where(ledger: @owned_ledger, name: @income_type).first
  move = @owned_ledger.incomes.find_by(amount: @amount, notes: @income_note,
                                       money_move_type_id: move_type.id,
                                       date: @income_date)
  expect(move).not_to be_nil
end
