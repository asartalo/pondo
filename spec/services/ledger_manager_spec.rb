require 'rails_helper'

RSpec.describe LedgerManager do
  let(:user) { create(:user) }
  let(:owner) { user }
  let(:ledger) { create(:ledger, owner: user) }
  subject(:manager) { LedgerManager.new(ledger, user) }

  it "has ledger" do
    expect(manager.ledger).to eql(ledger)
  end
end

