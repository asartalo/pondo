Given(/^I am not logged in$/) do
end

Given(/^I visit the '([^"]*)' page$/) do |name|
  visit PondoSpecs::Pages.send("#{ name }_page")
end

When(/^I log in$/) do
  find_link('Sign in With Google').click
end

Then(/^I should see the '([^"]*)' page$/) do |name|
  sleep 0.3
  uri = URI.parse(current_url)
  expect(uri.path).to eql(PondoSpecs::Pages.send("#{ name }_page"))
end
