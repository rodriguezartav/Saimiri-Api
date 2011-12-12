require "rubygems"
require 'sinatra'
require 'rack/cors'
require 'databasedotcom'

use Rack::Cors do
  allow do
    origins '*'
    resource '/contact', :headers => :any, :methods => :get
  end
end

get "allow_access" do
  '{"access": "granted"}'
end

post "/contact" do
  
end

post "/donations" do
  
end

