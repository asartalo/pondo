Given(/^I am at the '([^']*)' page$/) do |name|
  step "I visit the '#{name}' page"
end

Given(/^I visit the '([^']*)' page$/) do |name|
  visit pondo_page(name)
  wait_for_page_load
end

When(/^I go back$/) do
  sleep 0.3
  page.go_back
  sleep 0.3
end

When(/^I pause$/) do
  pause_pls
end

Then(/^I should see the '([^']*)' page$/) do |name|
  expect(page).to have_current_path(pondo_page(name))
end

Then(/^I should see '(.+)'$/) do |text|
  expect(page).to have_content(text)
end
