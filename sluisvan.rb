require 'rubygems'
require 'sinatra'
require 'lib/workitem'

before do
  config = {:server => "localhost", :db => "sluisvan"}
  Workitem.connect config
end

get "/" do
  erb :index
end

get "/show" do
  @workitems = Workitem.find_all
  erb :show
end

get "/new" do
  erb :new
end

post "/" do
  params.reject! {|k,v| k == "submit"}
  Workitem.save(params)
  redirect "/show"
end