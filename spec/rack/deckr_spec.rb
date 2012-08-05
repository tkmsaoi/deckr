require "spec_helper"

describe Rack::Deckr do
  before do
    p = deck_path
    mock_app do
      use Rack::Deckr, :url => "/hoge", :path => p
      not_found { "chained" }
    end
  end

  describe "env" do
    before { get "/" }
    subject { last_request.env["deckr.deck"] }
    it { should be_kind_of(Deckr::Deck) }
    its(:url) { should == "/hoge" }
    its(:path) { should == deck_path }
  end

  context "when requested file exists" do
    before { get "/hoge/core/deck.core.js" }
    subject { last_response }
    its(:body) { should =~ /^\/\*!\nDeck JS - deck.core/m }
    its(:body) { should =~ /\}\)\(jQuery, 'deck', document\);\n$/m }
  end

  context "when requested file doesn't exist" do
    before { get "/deck/foo" }
    subject { last_response }
    its(:body) { should == "chained" }
  end

  context "when requested url isn't known" do
    before { get "/hello" }
    subject { last_response }
    its(:body) { should == "chained" }
  end
end
