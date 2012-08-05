require "deckr"
require "rack/deckr"
require "sinatra/deckr"

require "rack/test"

module SpecHelper
  attr_reader :app

  def mock_app(base=Sinatra::Base, &block)
    @app = Sinatra.new(base, &block)
  end

  def deck_path
    File.expand_path("../../lib/deckr/templates/deck", __FILE__)
  end

  def fixtures
    @fixtures ||= double("fixtures",
      :url => "/fixtures", :path => File.expand_path("../fixtures", __FILE__))
  end
end

RSpec.configure do |c|
  c.include Rack::Test::Methods
  c.include SpecHelper
end
