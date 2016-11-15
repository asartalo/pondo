require 'rails_helper'

RSpec.shared_examples "creates ledger categories" do
  let(:names) { categories.collect(&:name) }

  it "creates correct number of categories" do
    expect(names.size).to eql(expected_categories.size)
  end

  it "creates categories with correct names" do
    expected_categories.each do |category_name, _|
      expect(names).to include(category_name)
    end
  end

  it "creates money move type" do
    expected_categories.each do |category_name, category|
      type_names = categories.find_by(name: category_name).send(types).collect(&:name)
      expect(type_names.length).to eql(category[:types].length)
      category[:types].each do |expected_type|
        expect(type_names).to include(expected_type)
      end
    end
  end
end

