require 'sinatra'
set :env, :production
disable :run

require './hello_tropo.rb'

run Sinatra::Application
