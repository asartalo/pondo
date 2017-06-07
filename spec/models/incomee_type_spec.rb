require 'rails_helper'
require_relative 'money_move_type_shared_examples'

RSpec.describe IncomeType, type: :model do
  it_behaves_like "a move type" do
    let(:money_move) { :income }
    let(:money_move_type_class) { IncomeType }
  end
end
