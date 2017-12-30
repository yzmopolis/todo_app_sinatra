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
  # redirect '/new' if @items.empty? OR NOT
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

post '/done' do
  item = Item.first(:id => params[:id])
  item.done = !item.done
  item.save
  content_type 'application/json'
  value = item.done ? 'done' : 'not done'
  { :id => params[:id], :status => value }.to_json
end

# delete '/:id' do
#   @items.delete(params[:id])
#   redirect '/'
# end

get '/delete/:id/?' do
  @item = Item.first(:id => params[:id])
end

post '/delete/:id/?' do
  if params.value?('OK')
    item = Item.first(:id => params[:id])
    item.destroy
    puts "bitch please"
  else
    puts "dupa"
  end
  redirect '/'
end