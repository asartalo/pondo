require 'rails_helper'

RSpec.describe LedgerManager do
  include ActiveJob::TestHelper

  let(:user) { create(:user) }
  let(:owner) { user }
  let(:builder) { LedgerBuilder.make(owner) }
  let(:ledger) { builder.create_ledger }
  subject(:manager) { LedgerManager.new(ledger, user) }

  it "has ledger" do
    expect(manager.ledger).to eql(ledger)
  end

  describe "#invite" do
    let(:email) { 'foo@somewhere.com' }
    subject(:invitation) do
      manager.invite(email)
    end

    before do
      clear_enqueued_jobs
      perform_enqueued_jobs { invitation }
    end

    it "sends invite email" do
      mail = ActionMailer::Base.deliveries.last
      expect(mail).not_to be_blank
    end

    it "sends invite email to correct address" do
      expect(invitation.to).to eql([email])
    end

    it "sends invite link" do
      expect(invitation.body.to_s).to match(%r{https?://.+/subscriptions/[\w-]{36}})
    end
  end

  {
    income: ["Active Income", "Salary"],
    expense: ["Living Expenses", "Groceries"]
  }.each do |move, type_args|
    describe (move == :income ? "#add_income" : "#deduct_expense") do
      let(:method) { (move == :income ? :add_income : :deduct_expense) }
      let(:type) { ledger.send("#{move}_type", *type_args) }
      subject(:added) do
        manager.send(method,
          amount: 300, date: Time.now, notes: "Crackers",
          money_move_type_id: type.id
        )
      end

      it "adds #{move}" do
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

end

