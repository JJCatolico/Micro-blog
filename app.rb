require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, { adapter: "sqlite3", database: "development.sqlite3" }

enable :sessions
