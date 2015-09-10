require 'rubygems'
require 'bundler'
Bundler.require
require 'sinatra'
require 'sinatra/reloader'
require 'rest_client'
require 'dotenv'

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
	RestClient.post "https://api:key-#{ENV['API_KEY']}"\
    "@api.mailgun.net/v3/sandbox#{ENV['SANDBOX_ID']}.mailgun.org/messages",
    :from => "Excited User  <mailgun@sandbox#{ENV['SANDBOX_ID']}.mailgun.org>",
	:to => "miki<#{ENV['MAIL_TO']}>",
	:subject => "お問い合わせがありました",
	:text => "こんにちは"
end