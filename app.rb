require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, { adapter: "sqlite3", database: "development.sqlite3" }

enable :sessions



def current_user
@current_user ||= User.find_by_id(session[:user_id])
end

def logged_in?
 @current_user && @current_user.id == session[:user_id]
end


get '/' do
  erb :index, :layout => :post
end

get '/users/dashboard' do 

	erb :'users/dashboard'
end

get '/login' do
	erb :login
end

post '/login' do 
	user = User.find_by(username: params[:user][:username])
	if user && user.password == params[:user][:password]
		session[:user_id] = user.id
		redirect '/'
	else 
		redirect '/login'
	end
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

get '/posts' do
	erb:posts
end

post '/posts' do 
  "My name is #{params[:name]}, and I love #{params[:favorite_food]}"
end


