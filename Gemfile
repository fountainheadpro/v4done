require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'http://rubygems.org'
gem 'rails', '3.1.1'
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end
gem 'therubyracer', '>= 0.9.8'
gem "rspec-rails", ">= 2.7.0", :groups => [:development, :test]
gem "database_cleaner", ">= 0.6.7", :group => :test
gem "mongoid-rspec", ">= 1.4.4", :group => :test
gem "factory_girl_rails", ">= 1.3.0", :group => :test
gem "cucumber-rails", ">= 1.1.1", :group => :test
gem "capybara", ">= 1.1.1", :group => :test
gem "launchy", ">= 2.0.5", :group => :test
gem "guard", ">= 0.6.2", :group => :development

case HOST_OS
  when /darwin/i
#    gem 'rb-fsevent', :groups => [:development, :test]
#    gem 'growl', :groups => [:development, :test]
  when /linux/i
#    gem 'libnotify', :groups => [:development, :test]
#    gem 'rb-inotify', :groups => [:development, :test]
  when /mswin|windows/i
    gem 'rb-fchange', :groups => :development
    gem 'win32console', :groups => :development
    gem 'rb-notifu', :groups => :development
end

gem 'rails-footnotes', '>= 3.7.5.rc4'
gem "guard-bundler", ">= 0.1.3", :group => :development
gem "guard-rails", ">= 0.0.3", :group => :development
gem "guard-livereload", ">= 0.3.0", :group => :development
gem "guard-rspec", ">= 0.4.3", :group => :development
gem "guard-cucumber", ">= 0.6.1", :group => :development
gem "bson_ext"
gem "mongoid"
gem 'mongoid-tree', :require => 'mongoid/tree'
gem "devise", ">= 1.4.9"
# gem "compass", "~> 0.12.alpha.0"
gem "settingslogic"
gem 'jquery-rails', '>= 1.0.12'
gem "heroku", :group => [:development, :test]
gem "rails-backbone"
gem "haml"