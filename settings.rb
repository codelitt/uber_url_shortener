configure :development do
  set :database, 'postgres://codelitt@localhost/url_shortener_development'
end

configure :test do
  set :database, 'postgres://codelitt:@localhost/url_shortener_test'
end

configure :production do
  set :database, 'postgres://deploy:password@localhost/url_shortener_production'
end
