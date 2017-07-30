def section_id(section)
  if section.match(/income/)
    '#add-income-section'
  else
    '#deduct-expense-section'
  end
end

When(/^I set the (income source|expense destination) to "([^"]*)"$/) do |kind, type|
  @money_type = type
  within section_id(kind) do
    select type, from: "Source"
  end
end


When(/^I set the (income|expense) date to ([\d\/]+)$/) do |kind, date|
  @money_date = Date.parse(date)
  within section_id(kind) do
    safe_date_fill_in "Date", @money_date
  end
end

When(/^I add an (income|expense) note to say "([^"]*)"$/) do |kind, note|
  @money_note = note
  within section_id(kind) do
    fill_in "Notes", with: note
  end
end

When(/^I submit the (income|expense)$/) do |kind|
  within section_id(kind) do
    click_button "Add Income"
  end
  wait_for_page_load
end

When(/^I select the (add income|deduct expense) section$/) do |section|
  find_link(section.titleize).click
  wait_for_remote_request
end

Then(/^I should see the add income section$/) do
  expect(page).to have_text("Add Income")
end

Then(/^I (could ){0,1}set the (income|expense) amount to (\d+)$/) do |_, kind, amount|
  @amount = amount
  within section_id(kind) do
    fill_in('Amount', with: amount)
  end
end

Then(/^I should see the (income|expense) added to (my own) ledger$/) do |kind, the_ledger|
  expect(find('#money-moves').text).to include(@amount)
  move_type = IncomeType.where(ledger: @owned_ledger, name: @money_type).first
  move = @owned_ledger.incomes.find_by(amount: @amount, notes: @money_note,
                                       money_move_type_id: move_type.id,
                                       date: @money_date)
  expect(move).not_to be_nil
end

When(/^I set the expense source to "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see the (income|expense) (.+) error$/) do |kind, field|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the (income|expense) form should reset$/) do |kind|
  container = find("#{section_id(kind)}")
  container.click # check if element is within screen and interactable
  form = container.find('form')
  %w{Amount Date Source Note}.each do |field|
    expect(form.find_field(field).value).to be_blank
  end
end
