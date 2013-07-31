use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['uber', 'cantstopme']  
end
