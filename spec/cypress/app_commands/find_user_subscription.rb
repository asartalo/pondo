me = User.find_by(email: params[:email])
me.subscribed_ledgers.find(params[:ledger])

