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
# Foreign Keys
#
#  fk_rails_f7b494f4c3  (user_id => users.id)
#

class Ledger < ApplicationRecord
  after_initialize :default_values
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  private
  def default_values
    if self.new_record?
      self.name ||= "My Ledger"
    end
  end
end
