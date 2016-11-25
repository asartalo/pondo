require 'rails_helper'
require_relative 'ledger_builder_shared_examples'

RSpec.describe LedgerBuilder do
  let(:user) { create(:user) }
  subject(:manager) { LedgerBuilder.new(user) }

  describe "#create_ledger" do
    let(:params) { {} }
    subject(:ledger) { manager.create_ledger(params) }

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
      let(:types) { :income_types }
      let(:expected_categories) do
        {
          "Active Income" => {
            description: "",
            types: [
              "Salary", "Side Jobs"
            ]
          },
          "Passive Income" => {
            types: [
              "Dividends"
            ]
          },
          "Others" => {
            types: [
              "Gifts / Donations"
            ]
          }
        }
      end
    end

    it_behaves_like "creates ledger categories" do
      subject(:categories) { ledger.expense_categories }
      let(:types) { :expense_types }
      let(:expected_categories) do
        {
          "Living Expenses" => {
            types: [
              "Food", "Groceries", "Rent / Mortgage", "Fare", "Medicines",
              "Other House Expenses", "Other Necessities"
            ]
          },
          "Optional Expenses" => {
            types: [
              "Movies / Trips", "Personal", "Unplanned Expenses", "Sports",
              "Dining Out", "Others"
            ]
          },
          "Payments" => {
            types: [
              "Amortization", "Landline / Internet", "Water", "Electricity",
              "Insurance", "Miscellaneous"
            ]
          },
          "Savings and Investments" => {
            types: [
              "Savings", "Investments"
            ]
          }
        }
      end
    end
  end
end

