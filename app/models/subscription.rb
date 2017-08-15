# == Schema Information
#
# Table name: subscriptions
#
#  id         :uuid             not null, primary key
#  email      :string
#  done       :boolean
#  ledger_id  :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_subscriptions_on_ledger_id  (ledger_id)
#
# Foreign Keys
#
#  fk_rails_...  (ledger_id => ledgers.id)
#

class Subscription < ApplicationRecord
  belongs_to :ledger

  validates_presence_of :ledger
  validates_presence_of :email
end
