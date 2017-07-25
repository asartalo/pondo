require 'rails_helper'
require_relative 'money_move_shared_examples'

RSpec.describe Income, type: :model do
  it_behaves_like "a transaction", :income do
    let(:money_move_class) { Income }
    let(:move_char) { "+" }
  end
end
