require "thor"
require "deckr"

module Deckr
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path("../templates", __FILE__)
    end

    desc "new DEST", "Generate a Sinatra application for deck.js"
    def new(dest)
      self.destination_root = File.expand_path(dest, destination_root)
      empty_directory "."
      template "Gemfile"
      copy_file "config.ru"
      directory "deck"
      directory "views"
    end
  end
end
