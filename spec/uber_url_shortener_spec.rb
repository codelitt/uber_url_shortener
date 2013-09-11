require 'spec_helper'

#def basic_auth(name, password)
#  if page.driver.respond_to?(:basic_auth)
#    page.driver.basic_auth(name, password)
#  elsif page.driver.respond_to?(:basic_authorize)
#    page.driver.basic_authorize(name, password)
#  elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
#    page.driver.browser.basic_authorize(name, password)
#  else
#    raise "I don't know how to log in!"
#  end
#end

describe "Basic features" do
  
  subject { page }
  
  it "should get through authentication and have basic links" do
    get '/'
    last_response.status.should be(401)
    basic_authorize "uber", "password1" 
    get '/' 
    last_response.status.should be(200)
  end

  it "should shorten url" do
    shortenedurl = FactoryGirl.create(:shortenedurl)
    ShortenedUrl.count.should == + 1
  end
  
  it "should redirect properly" do
    shortenedurl = FactoryGirl.create(:shortenedurl)
    get '/2'
    last_response.status.should be(301)
    last_response.headers["location"].should == ShortenedUrl.find_by_id(2).url
  end
end
