require 'sinatra'
require 'sinatra/reloader'
 
get '/' do
	# "Hello world!"

	@title = "はろーわーるど"
	erb :index

end