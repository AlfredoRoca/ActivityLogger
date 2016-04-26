source 'https://rubygems.org'
ruby "2.2.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# respond_to feature from rails 4.2
gem 'responders', '~> 2.1.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18.3' 
# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3.5'
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
gem 'jbuilder', '~> 2.3'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use debugger
# gem 'debugger', group: [:development, :test]

# A fast and very simple Ruby web server
gem 'eventmachine', '1.0.7'
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
# speed up development environment
  gem 'rails-dev-boost', :git => 'git://github.com/thedarkone/rails-dev-boost.git'
  # gem 'rb-inotify', '>= 0.8.8'
  # gem 'rb-fsevent', :require => false
  # gem 'rb-fchange', :require => false
  # The Bullet gem is designed to help you increase your application's performance by reducing the number of queries it makes. It will watch your queries while you develop your application and notify you when you should add eager loading (N+1 queries), when you're using eager loading that isn't necessary and when you should use counter cache.
  gem "bullet"
end

gem 'pry'
gem 'pry-rails'
group :development, :test do
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'guard-rspec'
  gem 'guard-livereload'
end

group :test do
  gem 'database_cleaner'
  gem 'capybara'
end

# Bootstrap Date and Time picker
# gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.7.14'

# Airbrussh is a replacement log formatter for SSHKit that makes your Capistrano output much easier on the eyes
gem "airbrussh", :require => false

gem 'devise'