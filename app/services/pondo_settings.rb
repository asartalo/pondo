class PondoSettings
  include Singleton
  attr_reader :config

  class << self

    def load_conf(config)
      new(config)
    end

    def get(*keys)
      instance.get(*keys)
    end
  end

  def initialize(config = nil)
    config ||= YAML.load_file(Rails.root.join('config', 'pondo_settings.yml'))
    @config = config.with_indifferent_access
  end

  def get(*keys)
    current = config
    keys.each do |key|
      if current.respond_to?(:key?) && current.key?(key)
        current = current[key]
      else
        raise PondoSettingsError, "Non-existent key '#{key}'"
      end
    end
    current
  end
end
