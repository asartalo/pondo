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
      row = where(country_code: country_code).first
      return nil unless row.present?
      row.currency
    end

    # Takes data from RestCountries and populates db
    def populate(countries)
      countries.each do |country|
        current = where(country_code: country.alpha2Code).first
        if current.present?
          current.update(currency: country.currencies.first)
        else
          create(country_code: country.alpha2Code, currency: country.currencies.first)
        end
      end
    end
  end
end
