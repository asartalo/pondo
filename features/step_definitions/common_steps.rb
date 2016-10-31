Given(/^I am not logged in$/) do
end

Given(/^I visit the '([^"]*)' page$/) do |name|
  visit PondoSpecs::Pages.send("#{ name }_page")
end

Given(/^I have a google account$/) do
  OmniAuth.config.mock_auth[:default] = {
   "provider"=>"google_oauth2",
   "uid"=>"100299566497892936264",
   "info"=>
   {"name"=>"john.doe@gmail.com",
    "email"=>"john.doe@gmail.com",
     "first_name"=>"John",
     "last_name"=>"Doe",
     "image"=>"https://example.com/photo.jpg"
    }
  }.with_indifferent_access
end

When(/^I log in$/) do
  find_link('Sign in With Google').click
end

Then(/^I should see the '([^"]*)' page$/) do |name|
  sleep 0.3
  uri = URI.parse(current_url)
  expect(uri.path).to eql(PondoSpecs::Pages.send("#{ name }_page"))
end

Given(/^I don't have a google account$/) do
  OmniAuth.config.mock_auth[:default] = :no_account
end

Then(/^I should see '(.+)'$/) do |text|
  expect(page).to have_content(text)
end
