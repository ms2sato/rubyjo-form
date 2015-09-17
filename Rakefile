require './myapp'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
ActiveRecod::Base.configuration = YAML.load_file('database.yml')
ActiveRecod::Base.establish_connection('development')