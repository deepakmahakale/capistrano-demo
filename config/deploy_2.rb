server '10.20.11.212', :app
set :user, 'deploy'

set :application, 'capistrano-demo'
set :repository,  'https://github.com/deepakmahakale/capistrano-demo'
set :deploy_to, "/var/www/#{application}"
set :bundle_dir, "#{deploy_to}/vendor/gems"
set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :use_sudo, false
set :linked_dirs, %w{vendor/bundle}
# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
after 'deploy:restart', 'deploy:cleanup'

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:

after 'deploy', 'deploy:bundle_gems'
after 'deploy:bundle_gems', 'deploy:restart'

namespace :deploy do
  task :bundle_gems do
    run "cd #{deploy_to}/current && bundle install vendor/gems"
  end
  task :start do
  end
  task :stop do
  end
  task :restart, roles: :app, except: { no_release: true } do
    run "#{try_sudo} touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end

# # set :placeholder, 'Deepak'

# server '10.20.11.212', :web
# set :user, 'vagrant'

# default_run_options[:pty] = true
# task :hello do
#   puts "Hello #{fetch(:placeholder, 'World')}"
#   # goodbye
#   run "#{sudo} cp ~/hello ~/abc"
# end

# # task :goodbye do
# #   puts "Goodbye #{placeholder}"
# # end

# # after :hello, :goodbye
