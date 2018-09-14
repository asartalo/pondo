params = command_options.with_indifferent_access
user = User.find_by(email: params[:email])
builder = LedgerBuilder.make(user)
builder.create_ledger(currency: "USD")

