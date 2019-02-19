# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, 'rails-101'
set :repo_url, 'git@github.com:GregNing/rails-101.git'

# rbenv的設定
set :rbenv_type, :user
set :rbenv_ruby, '2.2.2'
set :rbenv_path, '/usr/local/rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :rbenv_roles, :all # default value

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, '/home/apps/rails-101'
set :keep_releases, 5
# Default value for :format is :airbrussh.
# set :format, :airbrussh
set :log_level, :debug
# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w[config/database.yml config/secrets.yml]
# Default value for linked_dirs is []
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :ssh_options, forward_agent: true
# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
after 'deploy:publishing', 'deploy:restart'
after 'deploy:restart', 'unicorn:legacy_restart'
