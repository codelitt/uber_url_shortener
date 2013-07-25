require 'sinatra'
require 'sinatra/activerecord'

#App Files
require File.join(File.dirname(__FILE__), 'settings.rb') #Database

#Model. Later could be file

class ShortenedUrl < ActiveRecord::Base
  validates_uniqueness_of :url
  validates_presence_of :url
  validates_format_of :url, :with => URI::regexp(%w(http))
  
  def shorten
    self.id.alphadecimal
  end
end

#Routes

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
  short_url = ShortenedUrl.find(params[:shortened])
  redirect short_url.url
end


