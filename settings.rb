configure :development do
  set :database, 'postgres://codelitt@localhost/url_shortener_development'
end

configure :test do
  set :database, 'postgres://codelitt:@localhost/url_shortener_test'
end

configure :production do
 # db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///locahost/mydb')
  db = URI.parse('postgres://deploy:password@localhost/url_shortener_production')
  ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
end
