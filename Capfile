require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
require "capistrano/puma"
install_plugin Capistrano::Puma, load_hooks: true
require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/migrations'

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
