require 'rails_helper'

RSpec.describe LedgerManager do
  let(:user) { create(:user) }
  let(:owner) { user }
  let(:builder) { LedgerBuilder.make(owner) }
  let(:ledger) { builder.create_ledger }
  subject(:manager) { LedgerManager.new(ledger, user) }

  it "has ledger" do
    expect(manager.ledger).to eql(ledger)
  end

  describe "#add_income" do
    let(:type) { ledger.income_type("Active Income", "Salary") }
    subject(:added) do
      manager.add_income(amount: 300, date: Time.now, notes: "Crackers", money_move_type_id: type.id)
    end

    it "adds expense" do
      expect(added.amount).to eql(300)
    end

    it "takes notes" do
      expect(added.notes).to eql("Crackers")
    end

    it { is_expected.to be_persisted }

    context "if user is subscriber" do
      let(:owner) { create(:user) }

      before do
        ledger.subscribers << user
      end

      it { is_expected.to be_persisted }
    end

    context "if user is neither a subscriber nor owner" do
      let(:owner) { create(:user) }

      it { is_expected.to be_blank }
    end
  end
end

