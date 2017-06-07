class LedgerManager
  attr_reader :ledger, :user

  def initialize(ledger, user)
    @ledger = ledger
    @user = user
  end

  def add_income(params)
    if ledger.allowed? user, :record
      ledger.incomes.create(params)
    end
  end
end
