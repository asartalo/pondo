require 'rails_helper'
require_relative 'money_move_shared_examples'

RSpec.describe Income, type: :model do
  it_behaves_like "a transaction" do
    let(:money_move) { :income }
    let(:money_move_class) { Income }
  end
end
