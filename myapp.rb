#PUsh用
require 'rubygems' 
require 'bundler'
Bundler.require
require 'sinatra'
require 'sinatra/reloader'
require 'rest_client'
require 'dotenv'
Dotenv.load
require 'yaml'
require 'active_record'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

class Mail < ActiveRecord::Base;
end


get '/' do
	@count = Mail.count
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
	mail=Mail.new
	mail.email=@email
	mail.message=@message
	mail.save
	send_simple_message(params[:email],params[:message])
	erb :thank
end
def send_simple_message(email, message)
	RestClient.post "https://api:key-#{ENV['API_KEY']}"\
    "@api.mailgun.net/v3/sandbox#{ENV['SANDBOX_ID']}.mailgun.org/messages",
    :from => "Excited User  <mailgun@sandbox#{ENV['SANDBOX_ID']}.mailgun.org>",
	:to => "お問い合わせフォーム<#{ENV['MAIL_TO']}>",
	:subject => "お問い合わせがありました",
	:text => "#{email}さんからお問い合わせがありました。\n内容：#{message}"
end