# == Schema Information
#
# Table name: ledger_subscribers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  ledger_id  :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ledger_subscribers_on_ledger_id              (ledger_id)
#  index_ledger_subscribers_on_user_id                (user_id)
#  index_ledger_subscribers_on_user_id_and_ledger_id  (user_id,ledger_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (ledger_id => ledgers.id)
#  fk_rails_...  (user_id => users.id)
#

class LedgerSubscriber < ApplicationRecord
  belongs_to :user
  belongs_to :ledger
end
