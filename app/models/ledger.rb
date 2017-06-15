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
  has_many :ledger_subscribers, dependent: :destroy
  has_many :subscribers, through: :ledger_subscribers,
                         source: 'user'

  validates_presence_of :owner

  has_many :incomes, class_name: 'Income', dependent: :destroy
  has_many :expenses, class_name: 'Expense', dependent: :destroy
  has_many :income_categories, dependent: :destroy
  has_many :expense_categories, dependent: :destroy

  default_scope { order(updated_at: 'DESC' ) }

  def allowed?(user, action)
    return true if user == owner
    if subscribers.include? user
      [:record, :view].include? action
    else
      false
    end
  end

  def create_category(type, options)
    send("#{type}_categories").create(options)
  end

  def income_type(category_name, income_type_name)
    get_type(:income, category_name, income_type_name)
  end

  def expense_type(category_name, expense_type_name)
    get_type(:expense, category_name, expense_type_name)
  end

  def get_type(move, category_name, type_name)
    category = send("#{move}_categories").find_by(name: category_name)
    return nil unless category
    category.send("#{move}_types").find_by(name: type_name)
  end

  private

  def default_values
    if self.new_record?
      self.name ||= "My Ledger"
    end
  end
end
