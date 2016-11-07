require 'rails_helper'

RSpec.describe Ledger, type: :model do
  let(:ledger) { Ledger.new }

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
    let(:user) { create(:user) }

    before do
      ledger.owner = user
      ledger.save
      ledger.reload
    end

    it "sets owner" do
      expect(ledger.owner.id).to eql(user.id)
    end
  end
end
