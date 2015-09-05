namespace :logs do
  desc "tail rails log" 
  task :tail_rails do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/#{fetch(:rails_env)}.log"
    end
  end

  desc "tail thin log" 
  task :tail_thin do
    on roles(:app) do
      execute "tail -f /var/www/log/al_thin.log"
    end
  end
end
