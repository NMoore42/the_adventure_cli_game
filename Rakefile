require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  #ActiveRecord::Base.logger = Logger.new(STDOUT)

  Pry.start
end

# desc 'seeds database with newest crypto prices and starts Coin Market App'
# task :start_app do
#   Rake::Task['db:seed'].invoke
#   ruby "bin/run.rb"
# end
