require 'tropo-webapi-ruby'
require 'rubygems'
require 'sinatra'

get '/' do
  "hello world! it's #{Time.now} here!"
end

#post '/test' do
#    data = JSON.parse(request.body.read)
#    json data
#end

post '/index.json' do
  
  t = Tropo::Generator.new
  
  t.call(:to => "+447472786867")
  t.say(:value => "Tag, you're it!")

  t.ask :name => 'color', 
        :timeout => 60, 
        :say => {:value => "What's your favorite color?  Choose from red, blue or green."},
        :choices => {:value => "red, blue, green"}
  
  t.on :event => 'continue', :next => '/continue.json'

  t.response
end


