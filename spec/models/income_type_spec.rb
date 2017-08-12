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

require 'rails_helper'
require_relative 'money_move_type_shared_examples'

RSpec.describe IncomeType, type: :model do
  it_behaves_like "a move type", :income do
    let(:money_move_type_class) { IncomeType }
  end
end
