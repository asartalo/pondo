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
    subject(:code) { ip2cc.get('8.8.8.8') }

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
      let(:body) do
        ''
      end

      it "returns nil" do
        expect(code).to be_nil
      end
    end
  end
end
