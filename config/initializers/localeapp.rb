begin
  if !defined?(Rails)
    require 'localeapp/rails'

    Localeapp.configure do |config|
      config.api_key = ENV['LOCALEAPP_API_KEY']
      config.polling_environments = []
      config.sending_environments = []
    end
  end
rescue
end
