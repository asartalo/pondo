# == Schema Information
#
# Table name: money_move_types
#
#  id          :uuid             not null, primary key
#  ledger_id   :uuid
#  category_id :uuid
#  name        :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_money_move_types_on_category_id  (category_id)
#  index_money_move_types_on_ledger_id    (ledger_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (ledger_id => ledgers.id)
#

class MoneyMoveType < ApplicationRecord
  belongs_to :ledger
  belongs_to :category

  validate :category_ledger_must_be_the_same

  def category_ledger_must_be_the_same
    if category.ledger_id != ledger_id
      errors.add(:"#{move_kind}_type", "must have the same ledger")
    end
  end
end
