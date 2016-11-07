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
#  fk_rails_288d7a0866  (user_id => users.id)
#  fk_rails_8a5ebb28c1  (ledger_id => ledgers.id)
#

class LedgerSubscriber < ApplicationRecord
  belongs_to :user
  belongs_to :ledger
end
