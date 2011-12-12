require "rubygems"
require 'sinatra'
require 'rack/cors'
require 'databasedotcom'
require File.expand_path(File.dirname(__FILE__) + "/pony_gmail.rb")

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
  "ok"
end



