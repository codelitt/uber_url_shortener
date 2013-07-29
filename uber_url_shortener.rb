require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'alphadecimal'
require 'sinatra/assetpack'
require 'less'
require 'haml'
#App files
require File.join(File.dirname(__FILE__), 'settings.rb') #Database

#Model. Later could be seperate file

class ShortenedUrl < ActiveRecord::Base
  validates_uniqueness_of :url
  validates_presence_of :url
  validates_format_of :url, :with => URI::regexp(%w(http))
  
  def shorten
    self.id.alphadecimal
  end

  def self.find_by_shortened(shortened)
    find(shortened.alphadecimal)
  end
end

class UberUrlShortener < Sinatra::Base
  set :root, File.dirname(__FILE__)
  #Less.paths << "#{UberUrlShortener.root}/app/css"
  
  register Sinatra::AssetPack

  enable :inline_templates

  assets do
    serve '/js',     from: 'app/js'        # Default
    serve '/css',    from: 'app/css'       # Default
    serve '/images', from: 'app/images'    # Default
    # Add all the paths that Less should look in for @import'ed files

    css :app, [
      # '/css/bootstrap.css', # bootstrap.less
      '/css/*.css'
#      '/css/*.min.css'
    ]

    js :app, [
     '/js/*.js'
    ] 

    css_compression :simple
    js_compression :jsmin
  end

  #Routes Controller

  get '/' do
    haml :index
  end

  post '/' do
    @short_url = ShortenedUrl.find_or_create_by_url(params[:url])
    if @short_url.valid?
      haml :success
    else 
      haml :index
    end
  end

  get '/:shortened' do
    short_url = ShortenedUrl.find_by_shortened(params[:shortened])
    redirect short_url.url
  end

  get '/about' do
    haml :about
  end

  run! if app_file == $0
end

