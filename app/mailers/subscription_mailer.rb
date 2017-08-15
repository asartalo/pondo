class SubscriptionMailer < ApplicationMailer
  def invite(subscription, from)
    @subscription = subscription
    @from = from
    ledger = @subscription.ledger
    email = @subscription.email
    mail(
      to: email,
      from: from.email,
      subject: "Pondo: #{from.name} wants you to contribute to #{ledger.name}"
    )
  end
end
