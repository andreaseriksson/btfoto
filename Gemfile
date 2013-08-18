source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'unicorn'
gem 'capistrano'

gem 'bcrypt-ruby', '~> 3.1.0'
gem "bootstrap-sass", "~> 2.3.2.0"
gem "font-awesome-rails"
gem "haml"
gem "simple_form", '3.0.0.rc'
gem "bourbon"

gem 'ancestry'
gem 'acts_as_list'
gem 'ranked-model'

gem 'monban'
#gem "friendly_id", "~> 4.0.9"
gem 'friendly_id', github: 'FriendlyId/friendly_id', branch: 'rails4'
gem 'carrierwave'
gem 'jquery-fileupload-rails'

gem "rspec-rails", :group => [:test, :development]
group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
  gem "faker"
  gem "poltergeist"
end

group :development do
  gem 'sqlite3'
  gem "better_errors"
  gem "binding_of_caller"
  gem "bullet"
end

group :production do
  gem "pg"
end

gem 'wkhtmltopdf-binary'
gem 'wicked_pdf'
gem 'will_paginate', '~> 3.0'