# == Schema Information
#
# Table name: country_currencies
#
#  id           :integer          not null, primary key
#  country_code :string
#  currency     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_country_currencies_on_country_code  (country_code)
#  index_country_currencies_on_currency      (currency)
#

require 'rails_helper'

class PondoFakeRestCountry
  attr_reader :alpha2Code, :currencies

  def initialize(code, currencies)
    @alpha2Code = code
    @currencies = currencies
  end
end

RSpec.describe CountryCurrency, type: :model do
  subject(:model) { CountryCurrency }

  describe ".get" do
    before do
      CountryCurrency.create(country_code: 'PH', currency: 'PHP')
    end

    let(:country_code) { 'PH' }
    subject(:currency) { model.get(country_code) }

    it "finds currency by country code" do
      expect(currency).to eql('PHP')
    end

    context "when no currency is available for country code" do
      let(:country_code) { 'US' }

      it { is_expected.to be_nil }
    end
  end

  describe ".populate" do
    let(:countries) do
      [
        PondoFakeRestCountry.new('PH', ['PHP']),
        PondoFakeRestCountry.new('UY', ['UYI', 'UYU']),
      ]
    end

    subject(:populate) { model.populate(countries) }
    before { populate }

    it "populates db with codes" do
      expect(model.get('PH')).to eql('PHP')
      expect(model.get('UY')).to eql('UYI')
    end

    context "when redone again with updated data" do
      before { model.populate([PondoFakeRestCountry.new('UY', ['UYU'])]) }

      it "only updates fields" do
        expect(model.get('UY')).to eql('UYU')
        expect(model.count).to eql(2)
      end
    end
  end
end

