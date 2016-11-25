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

  def create_ledger(params = {})
    ledger = Ledger.create params.merge(owner: user)
    create_income_categories(ledger)
    create_expense_categories(ledger)
    ledger
  end

  private

  def create_categories(ledger, kind, names)
    names.each do |category_name, info|
      create_category(ledger, kind, category_name, info[:types])
    end
  end

  def create_category(ledger, kind, category_name, types)
    category = ledger.create_category(kind, name: category_name)
    types.each do |type_name|
      category.send("create_#{kind}_type", type_name)
    end
  end

  def create_income_categories(ledger)
    create_categories(ledger, :income, INCOME_CATEGORIES)
  end

  def create_expense_categories(ledger)
    create_categories(ledger, :expense, EXPENSE_CATEGORIES)
  end
end
