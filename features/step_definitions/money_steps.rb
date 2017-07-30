def section_id(kind)
  income_or_expense(kind, '#add-income-section', '#deduct-expense-section')
end

def income_or_expense(kind, first, second)
  if kind.match(/income/)
    first
  else
    second
  end
end

When(/^I set the (income source|expense type) to "([^"]*)"$/) do |kind, type|
  @money_type = type
  within section_id(kind) do
    select type, from: income_or_expense(kind, "Source", "Type")
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
  button = income_or_expense(kind, "Add Income", "Deduct Expense")
  within section_id(kind) do
    click_button button
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
  type_class = income_or_expense(kind, IncomeType, ExpenseType)
  expect(find('#money-moves').text).to include(@amount)
  move_type = type_class.where(ledger: @owned_ledger, name: @money_type).first
  move = @owned_ledger.send(:"#{kind}s").find_by(amount: @amount, notes: @money_note,
                                       money_move_type_id: move_type.id,
                                       date: @money_date)
  expect(move).not_to be_nil
end

Then(/^I should see the (income|expense) (.+) error$/) do |kind, field|
  within section_id(kind) do
    expect(find_field(field.titleize).query_scope.has_css?(".field_with_errors")).to eql(true)
  end
end

Then(/^the (income|expense) form should reset$/) do |kind|
  container = find("#{section_id(kind)}")
  container.click # check if element is within screen and interactable
  form = container.find('form')
  known_fields = %w{Amount Date Note}
  known_fields.push income_or_expense(kind, "Source", "Type")
  known_fields.each do |field|
    expect(form.find_field(field).value).to be_blank
  end
end
