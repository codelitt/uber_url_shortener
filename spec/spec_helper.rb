require File.join(File.dirname(__FILE__), '..', 'uber_url_shortener.rb')
require 'sinatra'
require 'rack/test'
require 'factory_girl'
require 'database_cleaner'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
Dir[File.dirname(__FILE__)+"/factories/*.rb"].each {|file| require file }

#setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  @app || UberUrlShortener.new
end

Capybara.app = app

RSpec.configure do |config|
  config.include Rack::Test::Methods  
  config.include Capybara::DSL
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

