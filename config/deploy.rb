# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'ActivityLogger'
set :repo_url, 'git@github.com:AlfredoRoca/ActivityLogger.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
set :deploy_via, :copy
set :stages, %w(testing staging production) 
set :default_stage, 'staging'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# It's going to use airbrussh
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :ssh_options, { paranoid: false }
set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/deploy/staging.rb', 'config/local_env.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/uploads')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

# Prevent bundler to overwrite binstubs created by rails
set :bundle_binstubs, nil
# set :bundle_binstubs, -> { release_path.join('bin') }
