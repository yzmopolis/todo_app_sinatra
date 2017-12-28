require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/todo_list.db")

class Item
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, :required => true
  property :done, Boolean, :required => true, :default => false
  property :created, DateTime
end

DataMapper.finalize.auto_upgrade!

get '/' do
  @items = Item.all(:order => :created.desc)
  @title = "Should I stay or should I go?"
  # redirect '/new' if @items.empty?
  erb :index
end

get '/new' do
  @title = "Eggos? Add new task"
  erb :new
end

post '/new' do
  Item.create(:content => params[:content], :created => Time.now)
  redirect '/'
end
