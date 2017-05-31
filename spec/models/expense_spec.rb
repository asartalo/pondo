
require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:ledger) { create(:ledger, owner: create(:user)) }
  let(:expense_category) { create(:expense_category, ledger: ledger) }
  let(:expense_type) { create(:expense_type, expense_category: expense_category, ledger: ledger) }
  subject(:expense) { Expense.create(ledger: ledger, expense_type: expense_type)  }

  it { is_expected.to belong_to(:expense_type) }
  it { is_expected.to belong_to(:ledger) }

  it "has no errors on creation" do
    expect(expense.errors).to be_empty
  end

  it "can have expense type" do
    expense.expense_type = expense_type
    expense.save
    expect(expense.errors).to be_empty
    expense.reload
    expect(expense.expense_type).to eql(expense_type)
  end

end
