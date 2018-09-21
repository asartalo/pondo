user = params.permit(%w{email name uid image}).to_h
user[:provider] = "google_oauth2"
User.create(user)

