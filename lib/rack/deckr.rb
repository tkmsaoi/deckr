require "deckr"
require "pathname"

module Rack
  class Deckr
    F = ::File

    def initialize(app, opts={})
      @app = app
      @url = opts[:url] || "/deck"
      @path = opts[:path] || F.join(Dir.pwd, "deck")
    end

    def call(env)
      env["deckr.deck"] = ::Deckr::Deck.new(@url, @path)

      path = env["PATH_INFO"]

      return @app.call(env) unless path.start_with?(@url)

      path = Pathname(path).relative_path_from(Pathname(@url))
      path = F.expand_path(F.join(@path, path))

      return @app.call(env) unless path.start_with?(@path) && F.file?(path)

      file = Rack::File.new(@path)
      file.path = path
      file.serving(env)
    end
  end
end
