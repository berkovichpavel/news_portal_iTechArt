require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NewsPortal
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.i18n.default_locale = :en
    # config.assets.initialize_on_precompile = false
    config.active_job.queue_adapter = :sidekiq
    config.action_mailer.asset_host = 'http://localhost:3000/mailer'
    config.autoload_paths += %W[#{config.root}/lib #{config.root}/services]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
