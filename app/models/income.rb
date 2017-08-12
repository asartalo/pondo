# == Schema Information
#
# Table name: money_moves
#
#  id                 :uuid             not null, primary key
#  date               :date
#  amount             :decimal(14, 4)
#  notes              :text
#  type               :string
#  ledger_id          :uuid
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  money_move_type_id :uuid
#
# Indexes
#
#  index_money_moves_on_date                (date)
#  index_money_moves_on_ledger_id           (ledger_id)
#  index_money_moves_on_money_move_type_id  (money_move_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (ledger_id => ledgers.id)
#  fk_rails_...  (money_move_type_id => money_move_types.id)
#

class Income < MoneyMove
  belongs_to :income_type, foreign_key: "money_move_type_id"

  def move_kind
    :income
  end

  def move_char
    "+"
  end

  def move_type
    income_type
  end
end
