source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mongoid'

#new way of handling attr_accessible
gem 'strong_parameters', github: 'rails/strong_parameters'

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby'

# Image Uploading
gem "carrierwave-mongoid", :git => "git://github.com/jnicklas/carrierwave-mongoid.git", :branch => "mongoid-3.0"

# Image Processing
gem "mini_magick"

# Handle Markdown
gem 'redcarpet'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass'

  #adding jquery ui
  gem 'jquery-ui-rails'
end


group :development, :test do
  gem 'spork'
  gem 'guard-spork'
  gem 'rb-inotify'
  gem 'rspec-rails'
  gem 'mongoid-rspec'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'jasminerice'
  # To use ruby debugger
  gem 'debugger'
  # run rails s --debugger
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'