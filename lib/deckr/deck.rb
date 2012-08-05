require "pathname"

module Deckr
  class Deck < Resource
    attr_reader :url, :path
    alias_method :name, :path

    def initialize(url=".", path="deck")
      @parent = nil
      @url, @path = url, path
      @style = nil
      @transition = nil
      @extensions = {}
    end

    def resource(name)
      @resources ||= {}
      @resources[name.to_sym] ||= Resource.new(self, name)
    end

    def package(name)
      @packages ||= {}
      @packages[name.to_sym] ||= Package.new(self, name)
    end

    def core
      package("core")
    end

    def style(name=(omitted=true))
      omitted ? @style : @style = (name && resource("themes/style/#{name}.css"))
    end

    def transition(name=(omitted=true))
      omitted ? @transition : @transition = (name && resource("themes/transition/#{name}.css"))
    end

    def enable(*args)
      args.each do |name|
        @extensions[name.to_sym] ||= package("extensions/#{name}")
      end
      extensions
    end

    def disable(*args)
      args.each do |name|
        @extensions.delete(name.to_sym)
      end
      extensions
    end

    def extensions
      @extensions.values
    end

    def exist?
      File.directory?(path)
    end

    def content
      ""
    end
  end
end
