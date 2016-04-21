# config valid only for current version of Capistrano
lock '3.4.1'

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

Airbrussh.configure do |config|
  # Capistrano's default, un-airbrusshed output is saved to a file to
  # facilitate debugging.
  #
  # To disable this entirely:
  # config.log_file = nil
  #
  # Default:
  config.log_file = "log/capistrano.log"

  # Airbrussh patches Rake so it can access the name of the currently executing
  # task. Set this to false if monkey patching is causing issues.
  #
  # Default:
  config.monkey_patch_rake = true

  # Ansi colors will be used in the output automatically based on whether the
  # output is a TTY, or if the SSHKIT_COLOR environment variable is set.
  #
  # To disable color always:
  # config.color = false
  #
  # Default:
  config.color = :auto

  # Output is automatically truncated to the width of the terminal window, if
  # possible. If the width of the terminal can't be determined, no truncation
  # is performed.
  #
  # To truncate to a fixed width:
  # config.truncate = 80
  #
  # Or to disable truncation entirely:
  # config.truncate = false
  #
  # Default:
  config.truncate = :auto

  # If a log_file is configured, airbrussh will output a message at startup
  # displaying the log_file location.
  #
  # To always disable this message:
  # config.banner = false
  #
  # To display an alternative message:
  # config.banner = "Hello, world!"
  #
  # Default:
  config.banner = :auto

  # You can control whether airbrussh shows the output of SSH commands. For
  # brevity, the output is hidden by default.
  #
  # Display stdout of SSH commands. Stderr is not displayed.
  config.command_output = :stdout
  #
  # Display stderr of SSH commands. Stdout is not displayed.
  # config.command_output = :stderr
  #
  # Display all SSH command output.
  # config.command_output = [:stdout, :stderr]
  # or
  # config.command_output = true
  #
  # Default (all output suppressed):
  # config.command_output = false
end