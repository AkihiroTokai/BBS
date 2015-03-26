require 'sinatra'
require  'sinatra/reloader'
require 'active_record'

require './models/contributions.rb'

set :bind, '192.168.33.10'
set :port,  3000

get'/'do
	'Hello Sinatra!'
	@contents=Contribution.order("id desc").all
	#@contents = Contribution.all#Contribution.order("id desc").all
	erb :index
end
post '/new'do
	"Hello world"
	logger.info("名前:#{params[:user_name]},内容:#{params[:body]}")
	Contribution.create(:name => params[:user_name],
						:body => params[:body])	
	redirect '/'
end									   
