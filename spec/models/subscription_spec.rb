# == Schema Information
#
# Table name: subscriptions
#
#  id         :uuid             not null, primary key
#  email      :string
#  done       :boolean
#  ledger_id  :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_subscriptions_on_ledger_id  (ledger_id)
#
# Foreign Keys
#
#  fk_rails_...  (ledger_id => ledgers.id)
#

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:ledger) { create(:ledger, owner: create(:user)) }
  let(:email) { "foo@example.com" }
  subject(:subscription) { Subscription.create(ledger: ledger, email: email) }

  it { is_expected.to validate_presence_of(:ledger) }
  it { is_expected.to validate_presence_of(:email) }

  describe "#subscribe" do
    let(:user) { create(:user, email: email) }
    subject(:subscribe) { subscription.subscribe(user)  }

    before { subscribe }

    it "subscribes user to the ledger" do
      expect(user.subscribed_ledgers.find(ledger.id)).not_to be_blank
    end

    it "returns true" do
      expect(subscribe).to eql(true)
    end

    it "marks it as done" do
      expect(subscription).to be_done
    end

    context "if the user's email does not match subscribed email" do
      let(:user) { create(:user, email: "bar@gmail.com") }

      it "does not subscribe user to the ledger" do
        expect(user.subscribed_ledgers.where(id: ledger.id)).to be_blank
      end

      it "returns false" do
        expect(subscribe).to eql(false)
      end
    end
  end

  describe "#available?" do
    context "when subscription is not done" do
      it { is_expected.to be_available }
    end

    context "when subscription is done" do
      before { subscription.update(done: true) }

      it { is_expected.not_to be_available }
    end
  end
end

