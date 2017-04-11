if Sidekiq.server?
  # Run every day at 2nd day of the month
  Sidekiq::Cron::Job.create(
    name: 'CountryCurrency Update',
    description: "Updates CountryCurrency data",
    cron: '0 0 2 * *',
    class: 'CountryCurrencyUpdateWorker'
  )
end
