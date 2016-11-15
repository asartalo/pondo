module ApplicationHelper
  def all_currencies
    # Money::Currency.table.values.collect { |c| c[:iso_code]  }
    Money::Currency.all
  end
end
