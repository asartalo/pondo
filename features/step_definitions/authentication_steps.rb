Given(/^I am not logged in$/) do
end

Given(/^I don't have a google account$/) do
  OmniAuth.config.mock_auth[:default] = :no_account
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

When(/^I log in for the first time$/) do
  step "I visit the 'home' page"
  step "I log in"
end

