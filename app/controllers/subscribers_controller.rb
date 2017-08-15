class SubscribersController < MainPagesController
  include Concerns::LedgerPagesConcern

  def index
    # redirect_to current_ledger_url
    render text: "TBD"
  end

  def create
    ledger_manager.invite(email)
    flash[:notice] = "Invitation Sent to #{email}"
    redirect_to current_ledger_url
  end

  private

  def email
    params[:email]
  end
end
