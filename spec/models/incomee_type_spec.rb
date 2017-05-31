require 'rails_helper'

RSpec.describe IncomeType, type: :model do
  let(:ledger) { create(:ledger, owner: create(:user)) }
  let(:category) { create(:income_category, ledger: ledger)  }
  subject(:income_type) { IncomeType.create(name: "Foo", income_category: category, ledger: ledger) }

  it { is_expected.to belong_to(:income_category) }
  it { is_expected.to validate_presence_of(:name) }

  it "has no errors on creation" do
    expect(income_type.errors).to be_empty
  end
end
