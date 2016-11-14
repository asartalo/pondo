class LedgerBuilder
  attr_reader :user
  INCOME_CATEGORIES = [
    "Active Income",
    "Passive Income",
    "Others"
  ]

  EXPENSE_CATEGORIES = [
    "Living Expenses",
    "Optional Expenses",
    "Payments",
    "Savings and Investments"
  ]

  def initialize(user)
    @user = user
  end

  def createLedger(params = {})
    ledger = Ledger.create params.merge(owner: user)
    createIncomeCategories(ledger)
    createExpenseCategories(ledger)
    ledger
  end

  private

  def createCategories(ledger, type, names)
    names.each do |category_name|
      ledger.send(:"#{type}_categories").create(name: category_name)
    end
  end

  def createIncomeCategories(ledger)
    createCategories(ledger, :income, INCOME_CATEGORIES)
  end

  def createExpenseCategories(ledger)
    createCategories(ledger, :expense, EXPENSE_CATEGORIES)
  end
end
