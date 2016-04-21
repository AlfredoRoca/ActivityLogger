namespace :rails do
  desc 'Start a rails console `cap [staging] rails:console`'
  task :console do
    on roles(:app) do |server|
      puts "Opening a console on: #{host}...."
      cmd = "ssh #{server.user}@#{host} -t 'cd #{fetch(:deploy_to)}/current && RAILS_ENV=#{fetch(:rails_env)} bundle exec rails console'"
      puts cmd
      exec cmd
    end
  end
end