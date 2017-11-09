require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './models'

# Database configuration
set :database, "sqlite3:development.sqlite3"

# messages index route
get '/' do
  @messages = Message.all
  erb :index
end

#messages edit route
post '/messages' do
  message = Message.create(
    title: params[:title],
    body: params[:body]
  )

  redirect "/messages/#{message.id}"
end

#messages new route
get '/messages/new' do
  erb :'messages/new'
end

patch '/messages/:id' do
  message = Message.find_by_id(params[:id])
  message.update(
    title: params[:title],
    body: params[:body]
  )

  redirect "/messages/#{message.id}"
end


#messages show route
get '/messages/:id' do
  @message = Message.find_by_id(params[:id])
  erb :'messages/show'
end

get '/messages/:id/edit' do
  @message = Message.find_by_id(params[:id])
  erb :'messages/edit'
end


# Providing model information to the view
# requires an instance variable (prefixing with the '@' symbol)

# Example 'User' index route

# get '/users' do
#   @users = User.all
#   erb :users
# end
