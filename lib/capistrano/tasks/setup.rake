namespace :setup do

  desc "Upload sensitive data files."
  task :upload_sensitive_files do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      # upload! StringIO.new(File.read("config/database.yml")), "#{shared_path}/config/database.yml"
      # upload! StringIO.new(File.read("config/secrets.yml")), "#{shared_path}/config/secrets.yml"
      # upload! StringIO.new(File.read("config/deploy/staging.rb")), "#{shared_path}/config/deploy/staging.rb"
      # upload! StringIO.new(File.read("config/local_env.yml")), "#{shared_path}/config/local_env.yml"
      upload! StringIO.new(File.read("config/local_vars.yml")), "#{shared_path}/config/local_vars.yml"
        puts "*************************************************************"
        puts "*************************************************************"
        puts "*************************************************************"
        puts "*************************************************************"
        puts " IMPORTANT! Edit and modify LOCAL_ENV.YML & DATABASE.YML"
        puts "*************************************************************"
        puts "*************************************************************"
        puts "*************************************************************"
        puts "*************************************************************"
    end
  end

  desc "Seed the database."
  task :seed_db do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "db:seed"
        end
      end
    end
  end

  desc "Symlinks config files for Nginx and Unicorn."
  task :symlink_config do
    on roles(:app) do
      execute "rm -f /etc/nginx/sites-enabled/default"

      execute "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{fetch(:application)}"
      # execute "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{fetch(:application)}"
   end
  end

end
