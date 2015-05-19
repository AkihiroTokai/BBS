require 'sinatra'
require  'sinatra/reloader'
require 'active_record'

require './models/contributions.rb'
require './image_uploader.rb'

set :bind, '192.168.33.10'
set :port,  3000

get'/'do
	'Hello Sinatra!'
	@contents=Contribution.order("id desc").all
	
	erb :index
end

post '/new' do 
	Contribution.create(:name => params[:name],
						:body => params[:body],
						:img => "")

	if params[:file]
		contents = Contribution.last
		id = contents.id
		ext = params[:file][:filename].split(".")[1]
		imgName = "#{contents.id}-bbs.#{ext}"
		contents.update_attribute(:img, imgName)

		save_path = "./public/images/#{imgName}"

		File.open(save_path,'wb') do |f|			
			f.write params[:file][:tempfile].read
			logger.info "アップロード成功"
		end
	else
		logger.info"アップロード失敗"
	end
end	
							   
post'/delete' do
	Contribution.find(params[:id]).destroy
end