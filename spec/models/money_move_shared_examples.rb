require 'rails_helper'

RSpec.shared_examples "a transaction" do |money_move|
  let(:ledger) { create(:ledger, owner: create(:user)) }
  let(:category) { create(:"#{money_move}_category", ledger: ledger) }
  let(:move_type) { create(:"#{money_move}_type", :"#{money_move}_category" => category, ledger: ledger) }
  subject(:the_money_move) do
    money_move_class.create(
      amount: 100,
      date: Date.parse("1/1/2001"),
      ledger: ledger, :"#{money_move}_type" => move_type
    )
  end

  it { is_expected.to belong_to(:"#{money_move}_type") }
  it { is_expected.to belong_to(:ledger) }
  it { is_expected.to belong_to(:ledger) }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:money_move_type_id) }

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

  describe "#amount_display" do
    before { ledger.currency = "USD" }
    subject(:display) { the_money_move.amount_display }

    it "formats amount for display" do
      expect(display).to eql("$100.00")
    end
  end

  describe "#move_char" do
    subject(:char) { the_money_move.move_char }
    it { is_expected.to eql(move_char) }
  end
end

