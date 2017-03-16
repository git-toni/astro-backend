require 'dotenv'
Dotenv.load(File.expand_path("../../.env.production",__FILE__))

#puts "HELLLLLLLLLLLL #{ENV['DB_USERNAME']}"

# config valid only for current version of Capistrano
lock "3.8.0"


server '45.32.152.42', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'https://github.com/git-toni/astro-backend'
set :application,     'astro'
set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0
# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
#set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :ssh_options,     { forward_agent: true, user: fetch(:user)}
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, false  # Change to true if using ActiveRecord

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
set :linked_files, %w{ .env.production }
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}


namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Import ENV'
  task :import_env do
    on roles(:app) do
      upload! File.expand_path("../../.env.production",__FILE__), "#{shared_path}/.env.production"
      #execute 'ls -a /home/deploy/apps/astro/shared'
      #execute "ln -nfs #{shared_path}/.env.production #{current_path}/.env.production"
    end
  end

  desc 'prepare database'
  task :prepare_db do
    on roles(:app) do
      #execute :ls, '-a'
      #execute "source #{shared_path}/.env.production; echo $DB_USERNAME"
      #execute 'pwd'
      #execute "psql -U postgres -d database_name -c 'create user #{ENV['DB_USERNAME']} with password #{ENV['DB_PASSWORD']};'"
      #execute "whoami"
      #execute "psql -U postgres -d database_name -c 'create user #{ENV['DB_USERNAME']} with password #{ENV['DB_PASSWORD']};'"
      #execute "sudo -u postgres bash -c \"psql -c \"CREATE USER vagrant WITH PASSWORD 'vagrant';\"\""
      #as :root do
      #  execute "whoami"
      #  #execute "psql -U postgres -d database_name -c 'create user #{ENV['DB_USERNAME']} with password #{ENV['DB_PASSWORD']};'"
      #  #execute "sudo -u postgres bash -c \"psql -c \"CREATE USER vagrant WITH PASSWORD 'vagrant';\"\""
      #end
      #execute "echo $DB_USERNAME"
      #execute :source, '.env.production'
      #execute 'source .env.production'
      #execute capture(Dir[shared_path])
      #execute :echo, '$DB_DBNAME'

    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      invoke "deploy:import_env"
      invoke "deploy:prepare_db"
      #puts "RELEASEPATH IS #{release_path}"
      #execute(Dir['/home/*'])
      #within "#{current_path}" do
      #within release_path do
      #  with rails_env: fetch(:rails_env) do
      #    execute :pwd
      #  end
      #  #  with rails_env: "#{fetch(:stage)}" do
      #  #    execute :rake, "db:create"
      #  #  end
      #end

      execute 'cd /home/deploy/redis; redis-server'
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end


  desc 'Restart Redis'
  task :redis_restart do
    on roles(:app), in: :sequence, wait: 5 do
      with rails_env: fetch(:rails_env) do
        execute 'killall redis-server || true'
        execute "nohup redis-server & sleep 5 && echo", pty: false
      end
    end
  end


  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'deploy:redis_restart'
      #execute 'killall redis-server || true'
      #with rails_env: fetch(:rails_env) do
      #  execute "nohup redis-server & sleep 5 && echo", pty: false
      #end
      ##execute 'redis-server'
      ##invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  #after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
