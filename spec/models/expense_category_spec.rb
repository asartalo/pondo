# == Schema Information
#
# Table name: categories
#
#  id          :uuid             not null, primary key
#  type        :string
#  name        :string
#  description :text
#  ledger_id   :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_categories_on_ledger_id  (ledger_id)
#
# Foreign Keys
#
#  fk_rails_35644bee2c  (ledger_id => ledgers.id)
#

require 'rails_helper'

RSpec.describe ExpenseCategory, type: :model do
  let(:ledger) { create(:ledger, owner: create(:user)) }
  subject(:category) { ExpenseCategory.create(ledger: ledger)  }

  describe "#create_expense_type" do
    before { category.create_expense_type("Foo") }
    subject(:added) { category.expense_types.first }

    it "adds expense type" do
      expect(category.expense_types.size).to eql(1)
      expect(added.name).to eql("Foo")
    end

    it "persists expense type" do
      expect(added).to be_persisted
    end

    it "sets the ledger to the category's ledger" do
      expect(added.ledger_id).to eql(ledger.id)
    end
  end
end


