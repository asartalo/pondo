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

class CountryCurrency < ApplicationRecord
  class << self
    def get(country_code)
      find_by(country_code: country_code).try :currency
    end

    # Takes data from RestCountries and populates db
    def populate(countries)
      countries.each { |country| upsert_on_code(*rc_extract_data(country)) }
    end

    def rc_extract_data(country)
      return country.alpha2Code, country.currencies.first
    end

    def upsert_on_code(code, currency)
      where(country_code: code).first_or_create.update(currency: currency)
    end
  end
end
