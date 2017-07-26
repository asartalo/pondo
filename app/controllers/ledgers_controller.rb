class LedgersController < MainPagesController
  def create
    ledger = LedgerBuilder.new(current_user).create_ledger(ledger_params)
    redirect_to ledger_url(ledger)
  end

  def show
    # TODO: Make sure this is only visible to viewables
    @ledger = Ledger.find(params[:ledger_id])
    @income = @ledger.incomes.new
  end

  private

  def ledger_params
    params.require(:ledger).permit(:name, :currency)
  end
end
