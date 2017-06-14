require 'rails_helper'

RSpec.describe IpToCurrency do
  let(:cc_service) { double('CountryCurrency') }
  let(:ip2cc) { double('IpToCountryCode') }
  let(:cache_store) { spy('cache_store') }
  subject(:service) { IpToCurrency.new(ip2cc, cc_service, cache_store) }

  describe "#get" do
    let(:ip_address) { '8.8.8.8' }
    let(:currency) { nil }
    let(:country_code) { nil }
    let(:ip_address_key) { /ip2curr:.+/ }
    let(:cache_exists) { false }
    subject(:get) { service.get(ip_address) }

    before do
      allow(cache_store).to receive(:exist?).and_return(cache_exists)
      allow(cache_store).to receive(:read).with(ip_address_key).and_return(country_code_cache)
      allow(ip2cc).to receive(:get).with(ip_address).and_return(country_code)
      allow(cc_service).to receive(:get).with(country_code).and_return(currency)
    end

    context "when the ip is not cached" do
      let(:country_code_cache) { nil }

      context "and the country_code returned is nil" do
        it { is_expected.not_to be_present }

        it "stores nil result in cache" do
          get
          expect(cache_store).to have_received(:write).with(ip_address_key, nil)
        end
      end

      context "and the country_code returned is present" do
        let(:country_code) { "US" }

        context "and a currency is returned" do
          let(:currency) { "USD" }

          it { is_expected.to eql("USD") }

          it "stores currency in cache" do
            get
            expect(cache_store).to have_received(:write).with(ip_address_key, "USD")
          end
        end
      end
    end

    context "when the cached is warmed" do
      let(:country_code_cache) { "USD" }
      let(:cache_exists) { true }

      it { is_expected.to eql(country_code_cache) }
    end
  end
end
