require 'rails_helper'

RSpec.describe ExpenseType, type: :model do
  let(:ledger) { create(:ledger, owner: create(:user)) }
  let(:category) { create(:expense_category, ledger: ledger)  }
  subject(:expense_type) { ExpenseType.create(name: "Foo", expense_category: category, ledger: ledger) }

  it { is_expected.to belong_to(:expense_category) }
  it { is_expected.to validate_presence_of(:name) }

  it "has no errors on creation" do
    expect(expense_type.errors).to be_empty
  end
end
