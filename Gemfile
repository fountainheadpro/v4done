require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'http://rubygems.org'
gem 'rails', '3.1.1'
gem 'therubyracer', '>= 0.9.8'
gem 'rails-footnotes', '>= 3.7.5.rc4'
gem "bson_ext"
gem "mongoid"
gem 'mongoid-tree', :require => 'mongoid/tree'
gem "devise", ">= 1.4.9"
gem "settingslogic"
gem 'jquery-rails', '>= 1.0.12'
gem "rails-backbone"
gem "ejs"

group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem "guard-bundler", ">= 0.1.3"
  gem "guard-rails", ">= 0.0.3"
  gem "guard-livereload", ">= 0.3.0"
  gem "guard-rspec", ">= 0.4.3"
  gem "guard-cucumber", ">= 0.6.1"
  gem "guard", ">= 0.6.2"
end

group :test do
  gem "database_cleaner", ">= 0.6.7"
  gem "mongoid-rspec", ">= 1.4.4"
  gem "cucumber-rails", ">= 1.1.1"
  gem "capybara", ">= 1.1.1"
  gem "launchy", ">= 2.0.5"
  gem "guard-jasmine"
  case HOST_OS
    when /darwin/i
      gem 'rb-fsevent'
      gem 'growl_notify'
    when /linux/i
      gem 'libnotify'
      gem 'rb-inotify'
    when /mswin|windows/i
      gem 'rb-fchange'
      gem 'win32console'
      gem 'rb-notifu'
    end
end

group :development, :test do
  gem "heroku"
  gem "rspec-rails", ">= 2.7.0"
  gem "haml-rails"
  gem "capybara-webkit"
  gem 'jasmine'
  gem "jasminerice"
  gem "factory_girl_rails", ">= 1.3.0"
end
