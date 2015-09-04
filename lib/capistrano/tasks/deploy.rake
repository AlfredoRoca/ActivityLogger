namespace :deploy do

  desc "Makes sure local git is in sync with remote."
  task :check_revision do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end


  %w[start stop restart].each do |command|
    desc "#{command} Thin server."
    task command do
      on roles(:app) do
        server = "#{fetch(:rails_env)}"
        if server == "staging"
          execute "~/.rvm/wrappers/default/thin #{command} -C /etc/thin/activity_logger.yml"
        else # == "production"
          execute "/home/deployer/.rvm/wrappers/ruby-2.2.0@activity_logger/thin #{command} -C /etc/thin/activity_logger.yml"
        end
      end
    end
  end

after :published, :restart

end

