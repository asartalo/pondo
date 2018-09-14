user = command_options.with_indifferent_access
if user[:name]
  name = user[:name]
  first_name, last_name = name.split(" ")

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:default] = {
    "provider" =>"google_oauth2",
    "uid"      => user[:uid],
    "info"     => {
      "name"       => name,
      "email"      => user[:email],
      "first_name" => first_name,
      "last_name"  => last_name,
      "image"      => user[:image],
    }
  }.with_indifferent_access
else
  OmniAuth.config.mock_auth[:default] = :no_account
end
