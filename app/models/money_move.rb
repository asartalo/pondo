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

class MoneyMove < ApplicationRecord
  belongs_to :ledger

  validates_presence_of :amount
  validates_presence_of :date
  validates_presence_of :money_move_type_id
  validate :move_type_ledger_must_be_the_same

  def money_move_type
    send("#{move_kind}_type")
  end

  def money_move_categories
    send("#{move_kind}_categories")
  end

  def amount_display
    Money.new(amount * 100, ledger.currency).format
  end

  protected

  def move_type_ledger_must_be_the_same
    unless money_move_type && money_move_type.ledger_id == ledger_id
      errors.add(:"#{move_kind}_type", "must have the same ledger")
    end
  end
end
