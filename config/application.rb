require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ActivityLogger
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Madrid'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :es

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # 
    # read env vars file and export vars
    # 
    config.before_configuration do
      # env_file = File.join(Rails.root, 'config', 'local_env.yml')
      # YAML.load(File.open(env_file)).each do |key, value|
      #   ENV[key.to_s] = value
      # end if File.exists?(env_file)
      filepath = Rails.root + 'config/local_env.yml'
      if File.exists?(filepath)
        lines = IO.readlines(filepath)
        lines.each do |l|
          ENV[l.split('=')[0]] = l.split('=')[1]
        end
      end
    end

    # Only attempt update on local machine
    if Rails.env.development?
      # Update version file from latest git 
      File.open('REVISION', 'w') do |file|
        version = `git log -1 --date=short --format='%ad-%h'`
        file.write version
      end
    end

    # 
    # by Capistrano
    # 
    # Usage: ActivityLogger::Application::REVISION
    # 
    REVISION = File.read('REVISION')

  end
end
