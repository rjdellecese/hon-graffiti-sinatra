require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/quote'
require 'sinatra/base'
require 'sinatra/assetpack'
require 'rubygems'
require 'will_paginate'
require 'will_paginate/active_record'
require 'will_paginate-foundation'

assets do
  serve '/js', from: 'js'
  serve '/bower_components', from: 'bower_components'
  
  js :modernizr, [
    '/bower_components/modernizr/modernizr.js',
  ]
  
  js :libs, [
    '/bower_components/jquery/dist/jquery.js',
    '/bower_components/foundation/js/foundation.js'
  ]
  
  js :application, [
    '/js/app.js'
  ]
  
  js_compression :jsmin
end
  
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

get '/quotes' do
  @quotes = Quote.paginate(page: params[:page], per_page: 10)
  erb :quotes
end
