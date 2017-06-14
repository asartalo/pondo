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
#  fk_rails_7b3f6e061c  (category_id => categories.id)
#  fk_rails_e4c0fd2ac8  (ledger_id => ledgers.id)
#

class ExpenseType < MoneyMoveType
  belongs_to :expense_category, foreign_key: "category_id"
  has_many :expenses, foreign_key: "money_move_type_id", dependent: :delete_all

  validates_presence_of :name

  def move_kind
    :expense
  end
end
