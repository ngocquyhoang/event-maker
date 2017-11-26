require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module EventMaker
  class Application < Rails::Application
    config.load_defaults 5.1
    default_url_options[:host] = "https://zevent.date"

    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      html_tag
    }
  end
end
