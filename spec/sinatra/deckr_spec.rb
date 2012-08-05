require "spec_helper"

describe Sinatra::Deckr do
  context "when application uses Rack::Deckr" do
    before do
      mock_app do
        register Sinatra::Deckr
        use Rack::Deckr
        get "/" do
          "#{deck != nil && deck == request.env['deckr.deck']}"
        end
      end
      get "/"
    end
    subject { last_response.body }
    it { should == "true" }
  end

  context "when application doesn't use Rack::Deckr" do
    before do
      mock_app do
        register Sinatra::Deckr
        get "/" do
          "#{deck == nil}"
        end
      end
      get "/"
    end
    subject { last_response.body }
    it { should == "true" }
  end
end
