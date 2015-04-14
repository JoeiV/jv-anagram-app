require 'pathname'
require 'pg'
require 'active_record'
require 'logger'
require 'yaml'
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'

require 'erb'

APP_ROOT = Pathname.new(File.expand_path(File.dirname(__FILE__)))

APP_NAME = APP_ROOT.basename.to_s

DB_PATH  = APP_ROOT.join('db', APP_NAME + "_development.db").to_s

DB_NAME = APP_NAME + "_development.db"

TEST_DB_NAME = APP_NAME + "_test.db"

DB_USERNAME = 'codio'

# TO DO: replace with PostgreSQL superuser pw specified during installation or leave blank if no pw set up
DB_PASSWORD = ''

Dir[APP_ROOT.join('app', 'controllers', '*.rb')].sort{|a,b| !a.include?("index") ? 1 : -1 <=> b.include?("index") ? -1 : 1}.each { |f| require f }

Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |f| require f }

ActiveRecord::Base.logger = Logger.new(STDOUT)

Dir[APP_ROOT.join('app/models', '*.rb')].each do |model_file|
  filename = File.basename(model_file).gsub('.rb', '')
  autoload ActiveSupport::Inflector.camelize(filename), model_file
end

ActiveRecord::Base.establish_connection(
                                        :adapter  => 'postgresql',
                                        :database => DB_NAME,
                                        :host => 'localhost',
                                        :username => DB_USERNAME,
                                        :password => DB_PASSWORD
    )

helpers ApplicationHelper