require File.join(File.dirname(__FILE__), '..', 'uber_url_shortener.rb')
require 'sinatra'
require 'rack/test'

#ENV['RACK_ENV'] = "test"
#setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  @app || UberUrlShortener.new
end


RSpec.configure do |config|
  config.include Rack::Test::Methods  
end

