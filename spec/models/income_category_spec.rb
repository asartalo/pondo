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
#  fk_rails_...  (ledger_id => ledgers.id)
#

require 'rails_helper'
require_relative 'category_shared_examples'

RSpec.describe IncomeCategory, type: :model do
  it_behaves_like "a category", :income do
    let(:category_class) { IncomeCategory }
  end
end

