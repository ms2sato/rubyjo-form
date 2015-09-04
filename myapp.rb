require 'rubygems' # この辺を追記
require 'bundler'
Bundler.require
require 'sinatra'
require 'sinatra/reloader'
require 'rest_client'
require 'dotenv'
Dotenv.load
require 'yaml'
require 'active_record'

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection('development')

class Mail < ActiveRecord::Base;
end


 
get '/' do
	# "Hello world!"
	@count = Mail.count
	@title = "はろーわーるど"
	erb :index

end

get'/about' do
	erb :q
end

post '/check' do
	@email = params[:email]
	@message = params[:message]
	erb :check
end


# 変数を使ってver.
post '/send-mail' do
 	@email = params[:email]
	@message = params[:message]
	test = ""
	test << @email
	test << "さんからお問い合わせがありました\n内容："
	test << @message
	mail = Mail.new
	mail.email=@email
	mail.message=@message
	mail.save
	send_simple_message(params[:email],params[:message],test)
	erb :thank
end
def send_simple_message(email, message,test)
	RestClient.post "https://api:key-#{ENV['API_KEY']}"\
    "@api.mailgun.net/v3/sandbox#{ENV['SANDBOX_ID']}.mailgun.org/messages",
    :from => "Excited User <mailgun@sandbox#{ENV['SANDBOX_ID']}.mailgun.org>",
	:to => "miki<#{ENV['MAIL_TO']}>",
	:subject => "お問い合わせがありました",
	:text => test
end


# 直接打つver.
# post '/send-mail' do
#  	@email = params[:email]
# 	@message = params[:message]
# 	send_simple_message(params[:email],params[:message])
# 	erb :thank
# end

# def send_simple_message(email, message)
# 	RestClient.post "https://api:key-cabe4d08ae4cc3fab6b5946eb54f0123"\
#     "@api.mailgun.net/v3/sandboxcebbc7038ab145f1968fcd1e04eb9142.mailgun.org/messages",
#     :from => "Excited User <mailgun@sandboxcebbc7038ab145f1968fcd1e04eb9142.mailgun.org>",
# 	:to => "miki<miki.jy12@gmail.com>",
# 	:subject => "お問い合わせがありました",
# 	:text => "#{email}さんからお問い合わせがありました。\n内容：#{message}"
# end





# get '/test' do
# 	send_simple_message
# 	erb :thank
# end
# def send_simple_message
# 	 RestClient.post "https://api:key-ほにゃらら"\
# 	 "@api.mailgun.net/v3/sandboxほにゃらら",
# 	 :from => "Mailgun Sandbox <ほにゃらら>",
# 	 :to => "miki<ほにゃらら@ほにゃ>",
# 	 :subject => "Hello miki",
# 	 :text => "こんにちは"
# end


#  post '/send-mail' do
#  	@email = params[:email]
# 	@message = params[:message]
# 	def send_simple_message
# 	  RestClient.post "https://api:key-ほにゃらら"\
# 	  "@api.mailgun.net/v3/sandboxほにゃらら",
# 	  :from => "Mailgun Sandbox <ほにゃらら>",
# 	  :to => "miki<ほにゃらら@ほにゃ>",
# 	  :subject => "Hello miki",
# 	  :text => "こんにちは"
# 	end
# 	send_simple_message
# 	erb :thank
# end


# get'/check' do
# 	erb :check
# end