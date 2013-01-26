source 'https://rubygems.org'

# Rails 3.2.11 
gem 'rails', '3.2.11'

gem "pg"

# For Ubuntu to be happy
gem 'therubyracer'

# Tagging gem
gem 'acts-as-taggable-on', '~> 2.3.1'

# Votable gem
gem 'acts_as_votable'

# Devise
gem 'devise'

# ActiveRecord Reputation System for voting and user reputation
gem 'activerecord-reputation-system', require: 'reputation_system'

# Audited gem in order to track activity
gem "audited-activerecord", "~> 3.0"

# PostRank-URI for URI normalization
gem "postrank-uri", "~> 1.0.17"

# Engage! for user support forum
gem 'engagecsm'

group :development do
   gem 'sqlite3'
   # The following three gems will make sure Linux, Mac and Windows work (respectively)
   gem 'rb-inotify', :require => false
   gem 'rb-fsevent', :require => false
   gem 'rb-fchange', :require => false
   
   # Similiarly, the following two gems together ensure functionality for both Linux and Mac (respectively)
   gem 'libnotify' if /linux/ =~ RUBY_PLATFORM
   gem 'growl' if /darwin/ =~ RUBY_PLATFORM

   # Guard allows for monitoring file changes and reloading spec's
   gem 'guard'
   gem 'guard-rspec'
   
   # Spork is a rspec speed improving gem
   gem 'guard-spork'
   gem 'spork'
end

group :development, :test do
   # Jasmine spec testing gems
   # RSPEC is a testing framework for rails
   gem 'rspec-rails', '~> 2.0'
   # Simplecov is a code coverage generator that works with RSPEC
   gem 'simplecov', :require => false
   # Capybara allows for integration testing with RSPEC along with Selenium UI testing 
   gem 'capybara'
   # Debugger helps with debugging rails applications
   gem 'debugger'
   # Pry allows for an alternative IRB terminal and a lot of debugging functionality
   gem 'pry'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

