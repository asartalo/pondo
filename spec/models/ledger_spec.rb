require 'rails_helper'

RSpec.describe Ledger, type: :model do
  let(:owner) { create(:user) }
  let(:ledger) { Ledger.new }

  before do
    ledger.owner = owner
  end

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
    let(:subscriber) { create(:user) }

    before do
      ledger.subscribers << subscriber
      ledger.save
      ledger.reload
    end

    it "adds subscriber" do
      expect(ledger.subscribers.first.id).to eql(subscriber.id)
    end
  end
end
