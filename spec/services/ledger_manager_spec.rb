require 'rails_helper'

RSpec.describe LedgerManager do
  let(:user) { create(:user) }
  subject(:manager) { LedgerManager.new(user) }

  describe "#createLedger" do
    subject(:created) { manager.createLedger }

    it "sets owner to the user" do
      expect(created.owner.id).to eql(user.id)
    end
  end
end

