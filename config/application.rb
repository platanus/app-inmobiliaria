require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AppInmobiliaria
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.autoload_paths << Rails.root.join('.env')
    config.default_host = ENV['APPLICATION_HOST']
    config.action_controller.default_url_options = { host: ENV['APPLICATION_HOST'] }
    config.action_controller.asset_host = ENV['APPLICATION_HOST']
    Rails.application.routes.default_url_options[:host] = ENV['APPLICATION_HOST']



    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
