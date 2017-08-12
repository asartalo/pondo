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


require 'rails_helper'
require_relative 'money_move_shared_examples'

RSpec.describe Expense, type: :model do
  it_behaves_like "a transaction", :expense do
    let(:money_move_class) { Expense }
    let(:move_char) { "-" }
  end
end
