Given(/^I am not logged in$/) do
end

Given(/^I don't have a google account$/) do
  OmniAuth.config.mock_auth[:default] = :no_account
end

Given(/^I am a user$/) do
  User.create(
    provider: "google_oauth2",
    uid: "999999999999999999999",
    name: "John Doe",
    email: "john.doe@gmail.com",
    image: "https://example.com/photo.jpg"
  )
  step "I have a google account"
end

Given(/^I have a google account$/) do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:default] = {
    "provider"=>"google_oauth2",
    "uid"=>"999999999999999999999",
    "info"=> {
      "name"=>"John Doe",
      "email"=>"john.doe@gmail.com",
      "first_name"=>"John",
      "last_name"=>"Doe",
      "image"=>"https://example.com/photo.jpg"
    }
  }.with_indifferent_access
end

When(/^I log in$/) do
  find_link('Sign in With Google').click
  wait_for_page_load
end

When(/^I log in for the first time$/) do
  User.all.destroy_all
  step "I am logged in"
end

Given(/^I am logged in$/) do
  step "I visit the 'home' page"
  step "I log in"
end

