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

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:ledger) { create(:ledger, owner: create(:user)) }
  let(:email) { "foo@example.com" }
  subject(:subscription) { Subscription.create(ledger: ledger, email: email) }

  it { is_expected.to validate_presence_of(:ledger) }
  it { is_expected.to validate_presence_of(:email) }
end

