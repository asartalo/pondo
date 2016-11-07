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
                           primary_key: 'id'
  has_many :ledger_subscribers
  has_many :subscribed_ledgers, through: :ledger_subscribers,
                                source: 'ledger'

  class << self
    def from_omniauth(auth)
      user = find_by(provider: auth[:provider], uid: auth[:uid])
      unless user
        user = User.new
        user.email = auth[:info][:email]
        user.provider = auth[:provider]
        user.uid = auth[:uid]
        user.name = auth[:info][:name]   # assuming the user model has a name
        user.image = auth[:info][:image]
        user.save
      end
      user
    end
  end
end
