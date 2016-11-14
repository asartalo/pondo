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

class Category < ApplicationRecord
  belongs_to :ledger
end
