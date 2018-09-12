# == Schema Information
#
# Table name: ledgers
#
#  id             :uuid             not null, primary key
#  name           :string
#  currency       :string
#  savings_target :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#
# Indexes
#
#  index_ledgers_on_user_id  (user_id)
#

FactoryBot.define do
  factory :ledger do
    name { "My Ledger" }
    currency { "USD" }
  end
end
