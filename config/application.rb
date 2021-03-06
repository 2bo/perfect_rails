require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.time_zone = "Tokyo"
    # エラーメッセージに日本語が使われるようになる。ただし、日本語の辞書データ(rails-i18n)が必要
    config.i18n.default_locale = :ja

    config.active_storage.variant_processor = :vips
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # アプリケーションで独自定義した例外が発生したときに、pulibc/500.html以外を表示したい場合の例
    # config.action_dispatch.rescue_response.merge!(
    #   "YourNewException" => :not_found
    # )

  end
end
