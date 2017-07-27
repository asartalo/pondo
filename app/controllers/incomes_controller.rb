class IncomesController < MainPagesController
  include Concerns::LedgerPagesConcern

  def index
    redirect_to current_ledger_url
  end

  def create
    @income = ledger_manager.add_income(income_params)
    if @income.valid?
      redirect_to current_ledger_url
    else
      nitrolinks_location current_ledger_url(hash: "add-income-section")
      render template: 'ledgers/show'
    end
  end

  private

  def income_params
    params.require(:income).permit %i{amount money_move_type_id date notes}
  end
end
