class LedgerBuilder
  attr_reader :user
  INCOME_CATEGORIES = {
    "Active Income" => {
      types: ["Salary", "Side Jobs"]
    },
    "Passive Income" => {
      types: ["Dividends"]
    },
    "Others" => {
      types: ["Gifts / Donations"]
    }
  }

  EXPENSE_CATEGORIES = {
    "Living Expenses" => {
      types: [
        "Food", "Groceries", "Rent / Mortgage", "Fare", "Medicines",
        "Other House Expenses", "Other Necessities"
      ]
    },
    "Optional Expenses" => {
      types: [
        "Movies / Trips", "Personal", "Unplanned Expenses", "Sports",
        "Dining Out", "Others"
      ]
    },
    "Payments" => {
      types: [
        "Amortization", "Landline / Internet", "Water", "Electricity",
        "Insurance", "Miscellaneous"
      ]
    },
    "Savings and Investments" => {
      types: ["Savings", "Investments"]
    }
  }

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
    names.each do |category_name, info|
      category = ledger.create_category(type, name: category_name)
      info[:types].each do |type_name|
        category.send("create_#{type}_type", type_name)
      end
    end
  end

  def createIncomeCategories(ledger)
    createCategories(ledger, :income, INCOME_CATEGORIES)
  end

  def createExpenseCategories(ledger)
    createCategories(ledger, :expense, EXPENSE_CATEGORIES)
  end
end
