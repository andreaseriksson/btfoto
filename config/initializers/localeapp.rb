begin
  if !defined?(Rails)
    require 'localeapp/rails'

    Localeapp.configure do |config|
      config.api_key = 'KJL66gu57TogcQvJDgGwbc3xo4uC143dg9VCPWLAiavvvYXTgI' #CONFIG[:localeapp_api_key]
      config.polling_environments = []
      config.sending_environments = []
    end
  end
rescue
end
