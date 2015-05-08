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
        # execute "sudo /etc/init.d/thin #{command}"
        execute "sudo thin restart -C /etc/thin/activity_logger.yml"
      end
    end
  end

# task :restart do
#   on roles(:app), in: :sequence, wait: 1 do
#       # Your restart mechanism here, for example:
#       # execute :touch, release_path.join('tmp/restart.txt')
#       execute "systemctl restart thin"
#   end
# end

#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end

task :tell_must_restart do
  on roles(:app) do
    execute "echo 'MUST RESTART THIN AS SU: thin restart -C /etc/thin/activity_logger.yml'"
  end
end

# after :published, :restart
after :published, :tell_must_restart

end

