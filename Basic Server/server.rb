require 'sinatra'
require 'json'

# Listens on http://localhost:4567.
post '/' do
  puts "HEADERS"
  puts headers
  puts "RAW BODY"
  puts request.body.read

  # Respond with 200
  200
end
