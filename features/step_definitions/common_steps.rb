Given(/^I visit the '([^"]*)' page$/) do |name|
  visit PondoSpecs::Pages.send("#{ name }_page")
end

Then(/^I should see the '([^"]*)' page$/) do |name|
  expect(page).to have_current_path(PondoSpecs::Pages.send("#{ name }_page"))
end

Then(/^I should see '(.+)'$/) do |text|
  sleep 0.2
  expect(page).to have_content(text)
end
