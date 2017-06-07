
require 'rails_helper'
require_relative 'money_move_shared_examples'

RSpec.describe Expense, type: :model do
  it_behaves_like "a transaction" do
    let(:money_move) { :expense }
    let(:money_move_class) { Expense }
  end
end
