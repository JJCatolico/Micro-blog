require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, { adapter: "sqlite3", database: "development.sqlite3" }

enable :sessions

get '/' do 
	erb :index
end

get '/users/dashboard' do 

	erb :'users/dashboard'
end

get '/login' do
	erb :login
end

post '/login' do 
	user = User.find_by()
	session[:user_id] = user.id
	redirect '/'

end

get '/signup' do
	erb :signup
end

post '/signup' do
	user = User.create(params[:user])
	session[:user_id] = user.id
	redirect '/'
end

get '/logout' do
	session[:user_id] = nil
	redirect '/'
end

