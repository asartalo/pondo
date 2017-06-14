require 'rails_helper'

RSpec.shared_examples "a transaction" do |money_move|
  let(:ledger) { create(:ledger, owner: create(:user)) }
  let(:category) { create(:"#{money_move}_category", ledger: ledger) }
  let(:move_type) { create(:"#{money_move}_type", :"#{money_move}_category" => category, ledger: ledger) }
  subject(:the_money_move) { money_move_class.create(ledger: ledger, :"#{money_move}_type" => move_type)  }

  it { is_expected.to belong_to(:"#{money_move}_type") }
  it { is_expected.to belong_to(:ledger) }

  it "has no errors on creation" do
    expect(the_money_move.errors).to be_empty
  end

  it "can have #{money_move} type" do
    the_money_move.send("#{money_move}_type=", move_type)
    the_money_move.save
    expect(the_money_move.errors).to be_empty
    the_money_move.reload
    expect(the_money_move.send("#{money_move}_type")).to eql(move_type)
  end

  context "when #{money_move}_type's ledger is not the same as own" do
    let(:other_ledger) { create(:ledger, owner: create(:user)) }
    let(:category) { create(:"#{money_move}_category", ledger: other_ledger) }
    let(:move_type) do
      create(
        :"#{money_move}_type",
        :"#{money_move}_category" => category,
        ledger: other_ledger
      )
    end

    it "has errors" do
      expect(the_money_move.errors).not_to be_empty
    end
  end
end


