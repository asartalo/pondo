class IncomesController < MainPagesController
  before_action :authenticate_user!

  def index
    @ledger = Ledger.find(params[:ledger_id])
    redirect_to ledger_url(id: @ledger.id)
  end

  def create
    @ledger = Ledger.find(params[:ledger_id])
    manager = LedgerManager.new(@ledger, current_user)
    @income = manager.add_income(income_params)
    if @income.errors.empty?
      redirect_to ledger_url(id: @ledger.id)
    else
      response.headers["Nitrolinks-Location"] = ledger_url(id: @ledger.id) + "#add-income-section"
      render template: 'ledgers/show'
    end
  end

  private

  def income_params
    params.require(:income).permit %i{amount money_move_type_id date notes}
  end
end
