me = User.find_by(email: params[:email])
ledger = Ledger.find(params[:ledger])
raise "Did not find any Ledger with id: #{params[:ledger]}" unless ledger

my_ledger = me.subscribed_ledgers.find(params[:ledger])
raise "User #{me.email} does not have ledger #{params[:ledger]}" unless my_ledger

my_ledger.as_json

