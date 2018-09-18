sender = User.where(params[:sender].permit(:email, :uid, :image, :name)).first_or_create
builder = LedgerBuilder.make(sender)
invited_ledger = builder.create_ledger(currency: "USD")
manager = LedgerManager.new(invited_ledger, sender)
manager.invite(params[:my_email])
subscription = Subscription.last
{
  sender: sender,
  ledger: invited_ledger,
  subscription: subscription
}
