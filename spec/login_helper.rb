def login(uber, password1)
  page.visit("http://#{uber}:#{password1}@#{page.driver.rack_server.host}:#{page.driver.rack_server.port}/")
end
