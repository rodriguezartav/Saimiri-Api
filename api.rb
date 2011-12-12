require "rubygems"
require 'sinatra'
require 'rack/cors'
require 'databasedotcom'
require 'pony'

use Rack::Cors do
  allow do
    origins '*'
    resource '/contact', :headers => :any, :methods => :get
    resource '/donacion', :headers => :any, :methods => :get

  end
end

get "allow_access" do
  '{"access": "granted"}'
end

get "/" do
  return "ok"
end

post "/contact" do
  begin
  response['Access-Control-Allow-Origin'] = '*'
  Pony.mail(:to=>"dsolano@fundacionsaimiri.org",
              :from => params[:email],
              :subject=> "Email de "+ params[:name],
              :body => params[:message],
              :via => :smtp, :via_options => {
                :address => 'smtp.gmail.com',
                :port => '587',
                :user_name => 'roberto@coalicionsur.org',
                :password => 'monomono',
                :authentication => :plain,
                :domain => "coalicionsur.org"
               }
             )
    rescue => msg
      puts msg
      
      return "Error" + msg
    end
      redirect to(params[:return])
end

post "/donacion" do
  begin
  
  response['Access-Control-Allow-Origin'] = '*'
  Pony.mail(:to=>"donations@fundacionsaimiri.org",
              :from => params[:email],
              :subject=> "Donacion!!!",
              :body => params[:email],
              :via => :smtp, :via_options => {
                :address => 'smtp.gmail.com',
                :port => '587',
                :user_name => 'roberto@coalicionsur.org',
                :password => 'monomono',
                :authentication => :plain,
                :domain => "coalicionsur.org"
               }
             )
     rescue => msg
       puts msg
        return "Error" + msg
      end
             
      redirect to(params[:return])
end

