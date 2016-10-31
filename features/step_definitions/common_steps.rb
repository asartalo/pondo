Given(/^I visit the '([^"]*)' page$/) do |name|
  visit PondoSpecs::Pages.send("#{ name }_page")
end

Then(/^I should see the '([^"]*)' page$/) do |name|
  sleep 0.3
  uri = URI.parse(current_url)
  expect(uri.path).to eql(PondoSpecs::Pages.send("#{ name }_page"))
end

Then(/^I should see '(.+)'$/) do |text|
  expect(page).to have_content(text)
end
