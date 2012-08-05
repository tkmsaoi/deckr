require "sinatra/base"

module Sinatra
  module Deckr
    module Helpers
      def deck
        request.env["deckr.deck"]
      end
    end

    def self.registered(app)
      app.helpers Helpers
    end
  end

  register Deckr
end
