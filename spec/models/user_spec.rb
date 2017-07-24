require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  describe "#preferred_currency" do
    subject(:preferred_currency) { user.preferred_currency }

    it "defaults to nil" do
      expect(subject).to be_nil
    end

    context "when it has subscribed ledgers" do
      let(:owner) { create(:user) }

      before do
        user.subscribed_ledgers << create(:ledger, owner: owner)
        user.save
      end

      it "uses that ledger's currency" do
        expect(subject).to eql("USD")
      end

      context "when it also has owned ledgers" do
        before do
          ledger = create(:ledger, currency: "EUR", owner: user)
          ledger.save
          user.reload
        end

        it "uses owned ledger instead" do
          expect(subject).to eql("EUR")
        end
      end
    end
  end
end

