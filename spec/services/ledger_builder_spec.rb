require 'rails_helper'

RSpec.describe LedgerBuilder do
  let(:user) { create(:user) }
  subject(:manager) { LedgerBuilder.new(user) }

  describe "#createLedger" do
    let(:params) { {} }
    subject(:created) { manager.createLedger(params) }

    it "sets owner to the user" do
      expect(created.owner.id).to eql(user.id)
    end

    context "when name is set" do
      let(:params) { {name: "Foo"} }

      it "sets the name for that ledger" do
        expect(created.name).to eql("Foo")
      end
    end
  end
end

