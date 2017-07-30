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

class IncomeCategory < Category
  has_many :income_types, foreign_key: "category_id", dependent: :delete_all
  validates_presence_of :name

  def create_income_type(name)
    income_types.create(name: name, ledger: ledger)
  end

  def move_types
    income_types
  end
end
