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
    cached = cache.read(ip_key(ip_address))
    if cached.nil?
      country_currency.get(ip_to_country_code.get(ip_address)).tap do |currency|
        cache.write(ip_key(ip_address), currency || false)
      end
    else
      cached
    end
  end

  private

  def ip_key(ip_address)
    "ip2curr:#{hash(ip_address)}"
  end

  def hash(ip_address)
    @digest ||= Digest::SHA256.new
    @digest.hexdigest ip_address + Rails.application.secrets.secret_key_base
  end
end
