class CountryCurrencyUpdateWorker
  include Sidekiq::Worker

  def perform(*)
    countries = Restcountry::Country.all
    CountryCurrency.populate(countries)
  end
end

