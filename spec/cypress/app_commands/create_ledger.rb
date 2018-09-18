user = User.find_by(email: params[:email])
builder = LedgerBuilder.make(user)
builder.create_ledger(currency: "USD")

