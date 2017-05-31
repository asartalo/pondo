
require 'rails_helper'

RSpec.describe Income, type: :model do
  let(:ledger) { create(:ledger, owner: create(:user)) }
  let(:income_category) { create(:income_category, ledger: ledger) }
  let(:income_type) { create(:income_type, income_category: income_category, ledger: ledger) }
  subject(:income) { Income.create(ledger: ledger, income_type: income_type)  }

  it { is_expected.to belong_to(:income_type) }
  it { is_expected.to belong_to(:ledger) }

  it "has no errors on creation" do
    expect(income.errors).to be_empty
  end

  it "can have income type" do
    income.income_type = income_type
    income.save
    expect(income.errors).to be_empty
    income.reload
    expect(income.income_type).to eql(income_type)
  end

end
