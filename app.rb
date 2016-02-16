require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/quote'

get '/' do
  erb :index
end

post '/submit' do
  @quote = Quote.new(params[:quote])
  if @quote.save
    redirect '/quotes'
  else
    'You messed SOMETHING up.'
  end
end

get '/models' do
  @quotes = Quote.all
  erb :quotes
end
