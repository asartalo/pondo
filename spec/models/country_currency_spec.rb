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

