require File.join(File.dirname(__FILE__), '..', 'api.rb')

require "rack/test" 
set :enviroment , :test
 
def app           
  Sinatra::Application
end 
 
describe "API Service" do 
  include Rack::Test::Methods
 
  it "should send an email from contact form" do
     json = { :email => "salesforce@rodcocr.com" , :name => "Roberto Rodriguez" , :message => "Prueba" }
     post '/contact', json
     body = last_response.body    
     puts "Result " + body      
     last_response.status.should == 200
  end
  
  it "should send an email from donation invoice request" do
     json = { :email => "salesforce@rodcocr.com" }
     post '/donacion', json
     body = last_response.body   
     last_response.status.should == 200
      
  end
    
end  