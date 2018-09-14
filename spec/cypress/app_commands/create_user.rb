user = command_options.with_indifferent_access
user[:provider] = "google_oauth2"
User.create(user)

