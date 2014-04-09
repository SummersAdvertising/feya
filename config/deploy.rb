# -*- encoding : utf-8 -*-
require 'capistrano/ext/multistage'
require 'bundler/capistrano' #Using bundler with Capistrano

set :stages, %w(staging production)
#set :default_stage, "staging"
set :default_stage, "production"

set :assets_dependencies, %w(app/assets lib/assets vendor/assets Gemfile.lock config/routes.rb)
set :keep_releases, 5
after "deploy:update", "deploy:cleanup" 

require "delayed/recipes"  

after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"