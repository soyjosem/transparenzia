source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.5'

gem "refinerycms", github: "refinery/refinerycms", ref: "b090142aab1dd85a04b1202bdd677741126ef3e9"
gem 'refinerycms-i18n', github: 'refinery/refinerycms-i18n', ref: "be2aa8b2afe6156a187f0f28250db59f3d685259"
gem "protected_attributes"

# Use postgresql as the database for Active Record
gem 'pg'

gem 'iconv'
gem 'activerecord-import', '>= 0.4.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

gem 'will_paginate-foundation'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'rspec-mocks'
end

group :test do
  gem "factory_girl_rails", "~> 4.2.1"
  gem "capybara", "~> 2.1.0"
  gem "guard-rspec", "~> 3.1.0"
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
gem "capistrano", "~> 2.15.5", group: :development
gem "net-ssh", '~> 2.7.0'