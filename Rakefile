require './uber_url_shortener.rb'
require 'sinatra/activerecord/rake'
require 'rspec/core/rake_task'

desc "Run specs"
task :spec do
  RSpec::Core::RakeTask.new(:spec) do |task|
  task.pattern    = 'spec/**/*_spec.rb'
  end
end
