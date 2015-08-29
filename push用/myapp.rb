require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb :index
end

get '/about' do
	erb :about
end

get '/check' do
	erb :check
end

get '/thank' do
	erb :thank
end