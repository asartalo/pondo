require 'rails_helper'
require_relative 'ledger_builder_shared_examples'

RSpec.describe LedgerBuilder do
  let(:user) { create(:user) }
  subject(:manager) { LedgerBuilder.new(user) }

  describe "#createLedger" do
    let(:params) { {} }
    subject(:ledger) { manager.createLedger(params) }

    it "sets owner to the user" do
      expect(ledger.owner.id).to eql(user.id)
    end

    context "when name is set" do
      let(:params) { {name: "Foo"} }

      it "sets the name for that ledger" do
        expect(ledger.name).to eql("Foo")
      end
    end

    it_behaves_like "creates ledger categories" do
      subject(:categories) { ledger.income_categories }
      let(:expected_names) do
        [
          "Active Income",
          "Passive Income",
          "Others"
        ]
      end
    end

    it_behaves_like "creates ledger categories" do
      subject(:categories) { ledger.expense_categories }
      let(:expected_names) do
        [
          "Living Expenses",
          "Optional Expenses",
          "Payments",
          "Savings and Investments"
        ]
      end
    end
  end
end

