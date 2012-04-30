require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'http://rubygems.org'
gem 'rails', '3.1.1'
gem 'therubyracer', '>= 0.9.8'
gem "bson_ext"
gem "mongoid", ">=2.4.8"
gem 'mongoid-tree', :require => 'mongoid/tree'
gem "devise", ">= 2.0.4"
gem "settingslogic"
gem 'jquery-rails', '>= 1.0.12'
gem "rails-backbone"
gem "ejs"
gem "haml-rails"
gem "awesome_print"
gem "moonshado-sms"
gem "rails_best_practices"
gem 'omniauth-facebook'
gem 'omniauth-twitter'

group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass', '~> 2.0.0'
  gem 'jquery_mobile_rails', '>=1.0.1'
end

group :development do
  gem "guard-bundler", ">= 0.1.3"
  gem "guard-rails", ">= 0.0.3"
  gem "guard-rspec", ">= 0.4.3"
  gem "guard-cucumber", ">= 0.6.1"
  gem "guard", ">= 0.6.2"
  gem 'growl'
end

group :test do
  gem "cucumber-rails", ">= 1.1.1", require: false
  gem "database_cleaner", ">= 0.6.7"
  gem "mongoid-rspec", ">= 1.4.4"
  gem "capybara", ">= 1.1.1"
  gem "launchy", ">= 2.0.5"
  gem "guard-jasmine"
  gem 'rb-fsevent'
  gem 'email_spec'
  gem 'simplecov', :require => false
end

group :development, :test do
  gem "heroku"
  gem "rspec-rails", ">= 2.7.0"
  gem "capybara-webkit"
  gem 'jasmine'
  gem "jasminerice"
  gem "factory_girl_rails", ">= 1.3.0"
end
