require 'sinatra'
require 'json'

get '/' do
  'hi'
  end

  post '/' do
    puts request.POST.to_json
    puts request.body.read
      200
      end
