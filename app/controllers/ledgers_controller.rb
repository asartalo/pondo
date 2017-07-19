class LedgersController < ApplicationController
  before_action :authenticate_user!

  def create
    LedgerBuilder.new(current_user).create_ledger(ledger_params)
    redirect_to dashboard_url
  end

  private

  def ledger_params
    params.require(:ledger).permit(:name, :currency)
  end
end
