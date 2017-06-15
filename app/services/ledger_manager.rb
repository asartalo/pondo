class LedgerManager
  attr_reader :ledger, :user

  def initialize(ledger, user)
    @ledger = ledger
    @user = user
  end

  def add_income(params)
    for_recorders_only { incomes.create(params) }
  end

  def add_expense(params)
    for_recorders_only { expenses.create(params) }
  end

  protected

  def incomes
    ledger.incomes
  end

  def expenses
    ledger.expenses
  end

  def for_recorders_only
    if ledger.allowed? user, :record
      yield
    end
  end
end
