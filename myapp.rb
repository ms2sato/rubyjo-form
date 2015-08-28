require 'sinatra'
require 'sinatra/reloader'
 
get '/' do
	# "Hello world!"

	@title = "はろーわーるど"
	erb :index

end

get'/about' do
	erb :q
end

get'/thank' do
	erb :thank
end

post '/check' do
	@email = params[:email]
	@message = params[:message]
	erb :check
end
# get'/check' do
# 	erb :check
# end