source 'https://rubygems.org'
ruby "2.2.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# respond_to feature from rails 4.2
gem 'responders', '~> 2.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18.1' 
# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3.4'
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development, :test do
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.1.0'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'spring-commands-rspec'
  gem 'guard-rspec'
end

# speed up development environment
group :development do
  gem 'rails-dev-boost', :git => 'git://github.com/thedarkone/rails-dev-boost.git'
  gem 'rb-inotify', '>= 0.8.8'
end

gem 'sorcery'

group :test do
  gem 'database_cleaner'
  gem 'capybara'
end

# A fast and very simple Ruby web server
gem 'thin' 

# gem 'rails_12factor', group: :production

# pdf generator
gem 'prawn'

# paginator
gem 'kaminari'

# annotate schema in models, ...
gem 'annotate', '~> 2.6.5'

# Audit trail
gem "audited-activerecord", "~> 4.0"

# Use Capistrano for deployment
group :development do
  gem "capistrano", '~> 3.4.0'
  gem 'capistrano-rails', '~> 1.1'
  gem "capistrano-rvm"
  # IO lib to hide password input when doing capistrano
  gem 'highline', '~> 1.7.1'
  gem 'rvm1-capistrano3', require: false
end

# Bootstrap Date and Time picker
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.7.14'

gem 'carrierwave'
