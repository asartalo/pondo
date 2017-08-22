class SubscriptionsController < MainPagesController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :subscription

  def show
    if subscription && subscription.available?
      session[:subscription] = subscription.id
    else
      redirect_to root_url
    end
  end

  def subscribe
    subscription.subscribe(current_user)
    redirect_to ledger_path(subscription.ledger)
  end

  protected

  def subscription
    @subscription ||= Subscription.find(params[:id])
  end
end
