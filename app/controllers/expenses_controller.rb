class ExpensesController < MainPagesController
  include Concerns::LedgerPagesConcern

  def index
    redirect_to current_ledger_url
  end

  def create
    @expense = ledger_manager.deduct_expense(expense_params)
    if @expense.valid?
      redirect_to current_ledger_url(hash: "deduct-expense-section")
    else
      nitrolinks_location current_ledger_url(hash: "deduct-expense-section")
      render template: 'ledgers/show'
    end
  end

  private

  def expense_params
    params.require(:expense).permit %i{amount money_move_type_id date notes}
  end
end
