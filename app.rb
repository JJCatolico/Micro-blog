require 'sinatra'
require 'pry'
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


# get '/' do
#   erb :index, :layout => :post
# end

get '/users/dashboard' do

	erb :'users/dashboard'
end

get '/login' do
	erb :"users/login"
end

post '/login' do
	user = User.find_by(username: params[:user][:username])
	if user && user.password == params[:user][:password]
		session[:user_id] = user.id
		redirect '/'
	else
		redirect '/login'
	end
  erb "Params: #{params.inspect}"
end


get '/signup' do
	erb :"users/signup"
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


get '/' do
  @posts = Post.all.last(10).sort_by { |r| r.id }.reverse
  erb :index
end

post '/posts' do
  user = User.find_by_id(session[:user_id])
  post = user.posts.new(params[:post])
  if post.save && user.save
    redirect "/posts/#{post.id}"
  else
    redirect '/posts/new'
  end
end

get '/posts/new' do
  erb :"posts/new"
end

get '/posts/:id' do
  @post = Post.find_by_id(params[:id])
  @user = @post.user
  erb :"posts/show"
end

put '/posts/:id' do
  post = Post.find_by_id(params[:id])
  if post.update(params[:post])
    redirect "/posts/#{post.id}"
  else
    redirect "/posts/#{post.id}/edit"
  end
end

get '/posts/:id/edit' do
  @post = Post.find_by_id(params[:id])
  erb :"posts/edit"
end





# post '/posts/new' do
# 	Post.create(title:params[:title], content:params[:content], user_id:current_user.id)
# 	redirect '/home'

# end

# post '/posts' do
#   user = User.create(params[:post])
#   binding.pry
# end

# delete '/delete_post' do
#   redirect '/list_posts'
# end
