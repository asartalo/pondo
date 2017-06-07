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
require_relative 'category_shared_examples'

RSpec.describe ExpenseCategory, type: :model do
  it_behaves_like "a category", :expense do
    let(:category_class) { ExpenseCategory }
  end
end


