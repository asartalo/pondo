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
      query, attributes = omni_auth_params(auth.to_h.with_indifferent_access)
      where(query).first_or_create do |user|
        user.assign_attributes(attributes)
      end
    end

    def omni_auth_params(params)
      return params.slice(:provider, :uid), params[:info].slice(:email, :name, :image)
    end
  end

  def viewable_ledgers
    Ledger.where(id: owned_ledgers.select(:id)).or(Ledger.where(id: subscribed_ledgers.select(:id)))
  end

  def has_viewable_ledgers?
    viewable_ledgers.length > 0
  end

  def preferred_currency
    ledger = viewable_ledgers.first
    ledger ? ledger.currency : nil
  end
end
