class IpToCountryCode
  attr_reader :client
  SERVICE_URL = 'http://ip-api.com/json'

  def self.make
    new(Typhoeus)
  end

  def initialize(client)
    @client = client
  end

  def get(ip_address)
    return nil unless ip_address
    response = client.get("#{SERVICE_URL}/#{ip_address}")
    begin
      body = JSON.parse(response.body)
    rescue JSON::ParserError
      return nil
    end
    body["countryCode"]
  end
end
