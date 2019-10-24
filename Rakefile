require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  #ActiveRecord::Base.logger = Logger.new(STDOUT)

  Pry.start
end

desc 'migrates, seeds, and starts app'
task :start_game do
  "bundle install"
  Rake::Task['db:migrate'].invoke
  Rake::Task['db:seed'].invoke
  ruby "bin/run.rb"
end
