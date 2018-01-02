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

get '/delete/:id/?' do
  @title = "Are you sure you want to delete this?"
  @item = Item.first(:id => params[:id])
  erb :delete
end

post '/delete/:id/?' do
  if params.has_key?("YES")
    item = Item.first(:id => params[:id])
    item.destroy
    redirect '/'
  else
    puts "if not works"
    redirect '/'
  end
end

get '/edit/:id/?' do
  @title = "Why are you keeping this curiosity door locked?"
  @item = Item.first(:id => params[:id])
  erb :edit
end

post '/edit/:id/?' do
  @item = Item.first(:id => params[:id])
  @item.content = params[:content]
  @item.save
  redirect '/'
end

not_found do
  status 404
  @title = "Lost in the upside down. Error #404."
  erb :not_found
end
