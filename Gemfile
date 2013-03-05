source 'https://rubygems.org'

# Rails 3.2.11
gem 'rails', '3.2.11'

# For Ubuntu to be happy
gem 'therubyracer'

# Tagging gem
gem 'acts-as-taggable-on', '~> 2.3.1'

# Votable gem
gem 'acts_as_votable'

# Devise
gem 'devise'

#koala
gem 'koala'

gem 'activeadmin'

# Omniauth
gem 'omniauth'
gem 'omniauth-facebook'

#Cancan
gem "cancan"

# ActiveRecord Reputation System for voting and user reputation
gem 'activerecord-reputation-system', :require => 'reputation_system'

# Audited gem in order to track activity
gem "audited-activerecord", "~> 3.0"

# PostRank-URI for URI normalization
gem "postrank-uri", "~> 1.0.17"

# Engage! for user support forum
gem 'engagecsm'

# Bootstrap
gem "less-rails"
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'

# Postgresql gem for better continuous integration with Heroku
gem 'pg'

# pg_search for fulltext searching in postgresql
gem 'pg_search'

# will_paginate for easier pagination
gem 'will_paginate'

# Google search (limited to 100 queries for free)
gem "google-api-client", "~> 0.6.2"

# IMGKit for site thumbnails
gem "imgkit", "~> 1.3.7"

# Amazon S3 storage
gem 'aws-sdk', '~> 1.3.4'

# Paperclip for file uploads
gem "paperclip", :git => "git://github.com/thoughtbot/paperclip.git"

# For background jobs (image snap and uploading)
gem 'daemons'
gem 'delayed_job_active_record'

# Slim for slim syntax for erb html files
gem 'slim'
gem 'slim-rails'

# For time duration manipulation
gem "chronic_duration", "~> 0.10.2"

# For notification system (unread notifications)
gem 'unread'

# For notificaiton/activity system
gem 'public_activity'

group :development do
   # The following three gems will make sure Linux, Mac and Windows work (respectively)
   gem 'rb-inotify', :require => false
   gem 'rb-fsevent', :require => false
   gem 'rb-fchange', :require => false

   # Similiarly, the following two gems together ensure functionality for both Linux and Mac (respectively)
   group :darwin do
     gem 'growl', :require => false
   end
   group :linux do
     gem 'libnotify', :require => false
   end
   # if /linux/ =~ RUBY_PLATFORM
   #   gem 'libnotify', :require => false
   # elsif /darwin/ =~ RUBY_PLATFORM

   # end
   # gem 'libnotify' if /linux/ =~ RUBY_PLATFORM
   # gem 'growl' if /darwin/ =~ RUBY_PLATFORM

   # Guard allows for monitoring file changes and reloading spec's
   gem 'guard'
   gem 'guard-rspec'

   # Spork is a rspec speed improving gem
   gem 'guard-spork'
   gem 'spork'

   # For debugging, see http://railscasts.com/episodes/402-better-errors-railspanel
   gem "better_errors"
   gem "binding_of_caller"
   gem 'meta_request'
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
  gem 'coffee-script-source', '~> 1.4.0' # ADD THIS LINE, 1.5.0 doesn't compile ActiveAdmin JavaScript files

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
