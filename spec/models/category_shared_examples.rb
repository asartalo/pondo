require 'rails_helper'

RSpec.shared_examples "a category" do |money_move|
  let(:ledger) { create(:ledger, owner: create(:user)) }
  subject(:category) { category_class.create(ledger: ledger, name: "Foo")  }

  it { is_expected.to have_many(:"#{money_move}_types") }
  it { is_expected.to validate_presence_of(:name) }

  it "has no errors on creation" do
    expect(category.errors).to be_empty
  end

  describe "#create_#{money_move}_type" do
    before { category.send("create_#{money_move}_type", "Foo") }
    subject(:added) { category.send("#{money_move}_types").first }

    it "adds #{money_move} type" do
      expect(category.send("#{money_move}_types").size).to eql(1)
      expect(added.name).to eql("Foo")
    end

    it "persists #{money_move} type" do
      expect(added).to be_persisted
    end

    it "sets the ledger to the category's ledger" do
      expect(added.ledger_id).to eql(ledger.id)
    end
  end
end

