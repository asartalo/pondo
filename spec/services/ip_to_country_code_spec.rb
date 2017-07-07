require 'rails_helper'

class PondoFakeReponse
  attr_reader :body

  def initialize(body)
    @body = body
  end
end

RSpec.describe IpToCountryCode do
  let(:typhoeus) { double('Typhoeus') }
  subject(:ip2cc) { IpToCountryCode.new(typhoeus) }

  describe "#get" do
    let(:ip_address) { '8.8.8.8' }
    let(:body) do
      ''
    end
    subject(:code) { ip2cc.get(ip_address) }

    before do
      allow(typhoeus).to receive(:get).with('http://ip-api.com/json/8.8.8.8').and_return(response)
    end

    let(:response) do
      PondoFakeReponse.new(body)
    end

    context "successful typhoeus response" do
      let(:body) do
        {
          "city"=>"Mountain View",
          "country"=>"United States",
          "countryCode"=>"US",
          "status"=>"success"
        }.to_json
      end

      it "returns the country code from service" do
        expect(code).to eql("US")
      end
    end

    context "unsuccessful response" do
      let(:body) do
        {"status" => "fail"}.to_json
      end

      it "returns nil" do
        expect(code).to be_nil
      end
    end

    context "if body is unparseable" do
      it "returns nil" do
        expect(code).to be_nil
      end
    end

    context "if passed with local ip" do
      let(:ip_address) { '127.0.0.1' }

      it "does not call typhoeus" do
        expect(typhoeus).not_to have_received(:get)
      end

      it "returns nil" do
        expect(code).to be_nil
      end
    end
  end
end
