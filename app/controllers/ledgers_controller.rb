class LedgersController < ApplicationController
  def create
    LedgerBuilder.new(current_user).createLedger(ledger_params)
  end

  private

  def ledger_params
    params.require(:ledger).permit(:name, :currency)
  end
end
