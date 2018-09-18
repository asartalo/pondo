# == Schema Information
#
# Table name: ledgers
#
#  id             :uuid             not null, primary key
#  name           :string
#  currency       :string
#  savings_target :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#
# Indexes
#
#  index_ledgers_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Ledger, type: :model do
  let(:owner) { create(:user) }
  let(:ledger) { Ledger.new }
  let(:subscriber) { create(:user) }
  let(:other_user) { create(:user) }

  before do
    ledger.owner = owner
  end

  it { is_expected.to have_many(:incomes) }
  it { is_expected.to have_many(:expenses) }

  it "sets name to 'My Ledger' by default" do
    expect(ledger.name).to eql('My Ledger')
  end

  context "when constructed with name" do
    subject(:ledger) { Ledger.new(name: "Foo") }

    it "should set name" do
      expect(ledger.name).to eql("Foo")
    end
  end

  describe "Setting ownership" do
    before do
      ledger.save
      ledger.reload
    end

    it "sets owner" do
      expect(ledger.owner.id).to eql(owner.id)
    end
  end

  describe "Adding subscribers" do
    before do
      ledger.subscribers << subscriber
      ledger.save
      ledger.reload
    end

    it "adds subscriber" do
      expect(ledger.subscribers.first.id).to eql(subscriber.id)
    end
  end

  describe "#allowed?" do
    subject(:allowed) { ledger.allowed?(user, action) }
    before do
      ledger.subscribers << subscriber
    end

    # TEST DATA
    {
      "owner" => {
        edit: true,
        delete: true,
        view: true,
        record: true,
        invite: true
      },

      "subscriber" => {
        edit: false,
        delete: false,
        view: true,
        record: true,
        invite: false
      },

      "other_user" => {
        edit: false,
        delete: false,
        view: false,
        record: false,
        invite: false
      }

    }.each do |the_user, data|
      context "for #{the_user}" do
        let(:user) { send(the_user) }

        data.each do |the_action, the_result|
          context "to :#{the_action}" do
            let(:action) { the_action.to_sym }
            it { is_expected.to be(the_result) }
          end
        end
      end
    end

  end

  context "built" do
    subject(:ledger) { LedgerBuilder.make(owner).create_ledger }

    {
      income: ["Active Income", "Salary"],
      expense: ["Living Expenses", "Groceries"],
    }.each do |move, correct_params|
      describe "##{move}_type" do
        let(:params) { correct_params }
        subject(:type) { ledger.send("#{move}_type", *params) }

        it "gets correct type" do
          expect(type.name).to eql(correct_params.last)
        end

        context "when the category is not valid" do
          let(:params) { ["Foo", correct_params.last] }
          it { is_expected.to be_nil }
        end

        context "when the type name is not valid" do
          let(:params) { [correct_params.first, "Foo"] }
          it { is_expected.to be_nil }
        end
      end
    end

    describe "#money_moves" do
      before do
        ledger.incomes.create(
          amount: 300, date: "12/01/2017",
          income_type: ledger.income_type("Active Income", "Salary")
        )
        ledger.incomes.create(
          amount: 200, date: "15/01/2017",
          income_type: ledger.income_type("Active Income", "Salary")
        )
        ledger.expenses.create(
          amount: 100, date: "14/01/2017",
          expense_type: ledger.expense_type("Living Expenses", "Groceries")
        )
      end

      subject(:money_moves) { ledger.money_moves }

      it "returns list of all money moves" do
        expect(money_moves.size).to eql(3)
      end

      it "orders them by date descending" do
        expect(money_moves.collect { |m| m.amount.to_i }).to eql([200, 100, 300])
      end
    end
  end
end
