require 'rubygems'
require 'bundler'
Bundler.require
require 'sinatra'
require 'sinatra/reloader'
require 'rest_client'

get '/' do
	erb :index
end

get '/about' do
	erb :about
end

post '/check' do
	@email = params[:email]
	@message = params[:message]
	erb :check
end

post '/send-mail' do
	@email = params[:email]
	@message = params[:message] 
	send_simple_message
	erb :thank
end
def send_simple_message
	RestClient.post "https://api:key-ほにゃらら"\
    "@api.mailgun.net/v3/sandboxほにゃらら",
    :from => "Excited User <ほにゃらら>",
	:to => "miki<ほにゃらら@ほにゃ>",
	:subject => "お問い合わせがありました",
	:text => "こんにちは"
end