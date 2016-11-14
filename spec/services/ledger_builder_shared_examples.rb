require 'rails_helper'

RSpec.shared_examples "creates ledger categories" do
  it "creates categories" do
    names = categories.collect(&:name)
    expect(names.size).to eql(expected_names.size)
    expected_names.each do |category|
      expect(names).to include(category)
    end
  end
end

