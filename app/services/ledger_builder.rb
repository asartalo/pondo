class LedgerBuilder
  attr_reader :user
  INCOME_CATEGORIES = PondoSettings.get(:ledger, :income_categories)
  EXPENSE_CATEGORIES = PondoSettings.get(:ledger, :expense_categories)

  def self.make(user)
    new(user)
  end

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
      create_category(ledger, kind: kind, name: category_name, types: info[:types])
    end
  end

  def create_category(ledger, options)
    kind = options[:kind]
    category = ledger.create_category(kind, name: options[:name])
    options[:types].each do |type_name|
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
