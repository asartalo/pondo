class IpToCurrency
  attr_reader :ip_to_country_code, :country_currency, :cache

  def self.make
    new(IpToCountryCode.make, CountryCurrency, Rails.cache)
  end

  def initialize(ip_to_country_code, country_currency, cache)
    @ip_to_country_code = ip_to_country_code
    @country_currency = country_currency
    @cache = cache
  end

  def get(ip_address)
    currency = nil
    cached = cache.read(ip_key(ip_address))
    if cached
      currency = cached
    else
      country_code = ip_to_country_code.get(ip_address)
      if country_code
        currency = country_currency.get country_code
      end
      cache.write(ip_key(ip_address), currency)
    end
    currency
  end

  private

  def ip_key(ip_address)
    "ip2curr:#{hash(ip_address)}"
  end

  def hash(string)
    @digest ||= Digest::SHA256.new
    @digest.hexdigest string
  end
end
