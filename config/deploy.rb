$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, 'ruby-1.9.2-p136'        # Or whatever env you want it to run in.
require "bundler/capistrano"
set :bundle_flags,    "--without test"
#
# Application
#
set :application, "ccpawa"
set :user, "root"
#set :domain, "demoapps.unep-wcmc.org"
set :deploy_to, "/var/www/#{application}"


#
# Settings
#
default_run_options[:pty] = true # Must be set for the password prompt from git to work
set :use_sudo, true
#set :shared_path, "/"

#
# Git
#
set :repository, "git@github.com:unepwcmc/CCPAWA.git"

set :scm, :git
set :branch, "master"
set :scm_username, "unepwcmc-read"
#set :git_enable_submodules, 1
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#
# Servers
#
role :web, "178.79.131.82"                          # Your HTTP server, Apache/etc
role :app, "178.79.131.82"                          # This may be the same as your `Web` server
role :db,  "178.79.131.82", :primary => true # This is where Rails migrations will run


# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

#task to run to link the database files properly
task :setup_production_database_configuration do
  mysql_password = Capistrano::CLI.password_prompt("Production PostGres password: ")
  require 'yaml'
  spec = { "production" => {
                                   "adapter" => "postgresql",
                                   "database" => 'ccpawa_production',
                                   "username" => 'wcmctest',
                                   "password" => mysql_password }}
  run "mkdir -p #{shared_path}/config"
  put(spec.to_yaml, "#{shared_path}/config/database.yml")
end


task :create_sym_links do
  run "(rm #{release_path}/config/database.yml && ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml) || echo 'not ready for this'"
  run "(rm #{release_path}/config/locales/fr.yml && ln -s #{shared_path}/config/locales/fr.yml #{release_path}/config/locales/fr.yml) || echo 'not ready for this'"
  run "(rm -rf #{release_path}/public/system && ln -s #{shared_path}/system #{release_path}/public/) || echo 'not ready for this'"
end

after "deploy:setup", :setup_production_database_configuration
after "deploy:setup", :create_sym_links

task :copy_production_database_configuration do
  run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end
# after "deploy:update_code", :copy_production_database_configuration

after :deploy, "passenger:restart"

after "deploy:update_code", :create_sym_links



