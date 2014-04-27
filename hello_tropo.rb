require 'tropo-webapi-ruby'
require 'rubygems'
require 'sinatra'
require 'mechanize'

get '/' do
  "hello world! it's #{Time.now} here!"
end

#post '/test' do
#    data = JSON.parse(request.body.read)
#    json data
#end
post '/index.json' do

  t = Tropo::Generator.new

  t.say "Good afternoon Mrs Green! This is a call from Crooksten Medical center to discuss your recent appointment with Dr Who."

  t.ask :name => 'color',
        :timeout => 60,
        :say => {:value => "Imagine I just summarized your glucoma consultation. Did you understand all of that?"},
        :choices => {:value => "no, yes"}
  t.on :event => 'continue', :next => '/q_further.json'

  t.response
end

post '/q_further.json' do

  v = Tropo::Generator.parse request.env["rack.input"].read

  t = Tropo::Generator.new

  answer = v[:result][:actions][:color][:value]

  t.say(:value => "You said " + answer)
  url = "https://sizzling-fire-6880.firebaseio.com/pie/.json"
  data = { positive:80, negative:10, callback:10}

  Mechanize.new.post url, data.to_json

  t.response

end


post '/index3455.json' do

  t = Tropo::Generator.new

  t.call(:to => "+13192142124") #+19168229887")
  #t.say(:value => "Tag, you're it!")
  t.say "Welcome to Tropo! Knock knock. Who's there?"

  t.ask :name => 'color',
        :timeout => 60,
        :say => {:value => "What's your favorite color?  Choose from red, blue or green."},
        :choices => {:value => "red, blue, green"}
  t.on :event => 'continue', :next => '/continue.json'

  t.response
end

post '/index55.json' do
  
  t = Tropo::Generator.new
  t.say "Welcome to Tropo! Knock knock. Who's there?"

  t.ask :name => 'color',
        :timeout => 60,
        :say => {:value => "What's your favorite color?  Choose from red, blue or green."},
        :choices => {:value => "red, blue, green"}
#  t.on :event => 'continue', :next => '/continue.json'
  t.on :event => 'continue', :next => '/call.json'


#  t.call(:to => "+447730466716")
#  b = Tropo::Generator.new
#  b.call(:to => "+447730466716")
#  b.say(:value => "Knock knock. Who's there?")


#  t.call(:to => "+447472786867")
#  t.say(:value => "Tag, you're it!")

#  t.ask :name => 'color', 
#        :timeout => 60, 
#        :say => {:value => "What's your favorite color?  Choose from red, blue or green."},
#        :choices => {:value => "red, blue, green"}
  
#  t.on :event => 'continue', :next => '/continue.json'

  t.response
end

post '/continue.json' do
  
  v = Tropo::Generator.parse request.env["rack.input"].read
  
  t = Tropo::Generator.new
  
  answer = v[:result][:actions][:color][:value]
  
  t.say(:value => "You said " + answer)
  
  t.response
  
end

post '/call.json' do

  t = Tropo::Generator.new
  t.call(:to => "+19168229887")

  t.say(:value => "Knock knock. Who's there?")

  t.ask :name => 'color',
        :timeout => 60,
        :say => {:value => "What's your favorite color?  Choose from red, blue or green."},
        :choices => {:value => "red, blue, green"}
  t.on :event => 'continue', :next => '/continue.json'


  t.response
  
end


