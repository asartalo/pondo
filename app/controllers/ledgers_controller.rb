class LedgersController < MainPagesController
  include Concerns::LedgerPagesConcern
  skip_before_action :set_ledger, only: [:create, :new]
  skip_before_action :set_invites, only: [:create, :new]

  def create
    ledger = LedgerBuilder.new(current_user).create_ledger(ledger_params)
    redirect_to ledger_url(ledger)
  end

  def show
    # TODO: Make sure this is only visible to viewables
    @income = @ledger.incomes.new
    @expense = @ledger.expenses.new
  end

  private

  def ledger_params
    params.require(:ledger).permit(:name, :currency)
  end
end
