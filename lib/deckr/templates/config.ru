require "rack/deckr"
require "sinatra"
require "sinatra/deckr"
require "slim"

use Rack::Deckr, :url => "/deck", :path => File.expand_path("../deck", __FILE__)

get "/" do
  slim :index
end

run Sinatra::Application
