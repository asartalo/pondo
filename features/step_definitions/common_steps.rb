Given(/^I am at the '([^']*)' page$/) do |name|
  step "I visit the '#{name}' page"
end

Given(/^I visit the '([^']*)' page$/) do |name|
  visit PondoSpecs::Pages.send("#{ name }_page")
  wait_for_page_load
end

Then(/^I should see the '([^']*)' page$/) do |name|
  expect(page).to have_current_path(PondoSpecs::Pages.send("#{ name }_page"))
end

Then(/^I should see '(.+)'$/) do |text|
  expect(page).to have_content(text)
end
