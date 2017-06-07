require 'rails_helper'

RSpec.shared_examples "a move type" do
  let(:ledger) { create(:ledger, owner: create(:user)) }
  let(:category) { create(:"#{money_move}_category", ledger: ledger) }
  subject(:move_type) { money_move_type_class.create(name: "Foo", :"#{money_move}_category" => category, ledger: ledger) }

  it { is_expected.to belong_to(:"#{money_move}_category") }
  it { is_expected.to validate_presence_of(:name) }

  it "has no errors on creation" do
    expect(move_type.errors).to be_empty
  end
end

