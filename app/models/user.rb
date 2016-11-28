# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           default(""), not null
#  name       :string           default(""), not null
#  provider   :string           default(""), not null
#  uid        :string           default(""), not null
#  image      :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :owned_ledgers, class_name: 'Ledger',
                           foreign_key: 'user_id',
                           primary_key: 'id',
                           dependent: :destroy
  has_many :ledger_subscribers, dependent: :destroy
  has_many :subscribed_ledgers, through: :ledger_subscribers,
                                source: 'ledger'

  class << self
    def from_omniauth(auth)
      params = auth.to_h.with_indifferent_access
      where(params.slice(:provider, :uid)).first_or_create do |user|
        user.assign_attributes(params[:info].slice(:email, :name, :image))
      end
    end
  end

  def viewable_ledgers
    owned_ledgers.to_a + subscribed_ledgers.to_a
  end

  def has_viewable_ledgers?
    viewable_ledgers.length == 0
  end
end
