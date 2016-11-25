class LedgersController < ApplicationController
  def create
    LedgerBuilder.new(current_user).create_ledger(ledger_params)
  end

  private

  def ledger_params
    params.require(:ledger).permit(:name, :currency)
  end
end
