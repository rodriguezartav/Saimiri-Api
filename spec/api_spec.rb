require File.join(File.dirname(__FILE__), '..', 'api.rb')

require "rack/test" 
set :enviroment , :test
 
def app           
  Sinatra::Application
end 
 
describe "API Service" do 
  include Rack::Test::Methods
 
  it "should login to salesforce and return token and instance_url" do
     json = { :username => "salesforce@rodcocr.com.test" , :password => "monomono1NpTn5D4Y1JzbKlV1uqgTwo4gf" }
     post '/login', json
     body = last_response.body    
     json = JSON.parse body
     puts "Result " + body      
     
     last_response.status.should == 200
  end
  
  it "should not login to salesforce and return token and instance_url" do
     json = { :username => "salesforce@rodcocr.com.test" , :password => "no_passuapMEv4IiUTlbO8RAwV5khBwP"}
     post '/login', json
     body = last_response.body    
     json = JSON.parse body
     json['success'].should == false
     json['error'].should_not == nil
  end
 
  it "should get clientes and productos" do
     queries = []
     query = 'select id , name from cliente__c where LastModifiedDate > 1999-01-01T23:01:01+01:00 limit 2'
     json = { :username => "salesforce@rodcocr.com.test" , :password => "monomono1NpTn5D4Y1JzbKlV1uqgTwo4gf" , :query=> query}
     post '/query', json
     body = last_response.body        
     json = JSON.parse body
     puts "Result " + body      
     last_response.status.should == 200
     json["results"].length.should == 2
  end

  it "should save two oportunidades" do
     items_raw = File.read(File.join(File.dirname(__FILE__), "/fixtures/pedido_success.json"))
     json = {:type => "Oportunidad__c" , :items => items_raw, :username => "salesforce@rodcocr.com.test" , :password => "monomono1NpTn5D4Y1JzbKlV1uqgTwo4gf"}
     post '/save', json
     puts last_response.body              
     last_response.status.should == 200  
     results =  JSON.parse last_response.body 
     results.length.should == 2 
     results[0]['success'].should == true
     results[1]['success'].should == true
     results[0]['source']['item_id'].should_not == nil
    end
  
    
end  