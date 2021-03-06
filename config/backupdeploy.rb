require 'dotenv'
Dotenv.load(File.expand_path("../../.env.production",__FILE__))


lock "3.8.0"


#server '45.32.152.42', port: 22, roles: [:web, :app, :db], primary: true
server '45.76.94.69', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'https://github.com/git-toni/astro-backend'
set :application,     'astro'
set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0

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
    end
  end

  desc 'prepare database'
  task :prepare_db do
    on roles(:app) do
      #execute "psql -U postgres -d database_name -c 'create user #{ENV['DB_USERNAME']} with password #{ENV['DB_PASSWORD']};'"
    end
  end


  desc 'make shared folders etc'
  task :make_folders do
    on roles(:app) do
      execute "mkdir -p #{deploy_to}/shared"
      #execute "psql -U postgres -d database_name -c 'create user #{ENV['DB_USERNAME']} with password #{ENV['DB_PASSWORD']};'"
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      invoke "deploy:make_folders"
      invoke "deploy:import_env"
      invoke "deploy:prepare_db"

      invoke 'deploy:redis_restart'
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
      ##invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  #after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

