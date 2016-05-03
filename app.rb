require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/quote'
require 'sinatra/base'
require 'sinatra/asset_pipeline'
require 'rubygems'
require 'will_paginate'
require 'will_paginate/active_record'
require 'will_paginate-foundation'
require 'sinatra/zero_clipboard'

register Sinatra::ZeroClipboard::Assets
register Sinatra::AssetPipeline
  
get '/' do
  @quotes = Quote.paginate(page: params[:page], per_page: 10)
  erb :index
end

post '/submit' do
  @quote = Quote.new(params[:quote])
  if @quote.save
    redirect '/'
  else
    'Quote must be between 2 and 160 characters in length.'
  end
end
