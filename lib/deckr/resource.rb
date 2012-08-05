module Deckr
  class Resource
    attr_reader :parent, :name

    def initialize(parent, name)
      @parent, @name = parent, name
    end

    def url
      File.join(parent.url, name)
    end

    def path
      File.join(parent.path, name)
    end

    def exist?
      File.file?(path)
    end

    def content
      if not exist?
        ""
      elsif RUBY_VERSION >= "1.9"
        IO.read path, :mode => "rb"
      else
        IO.read path
      end
    end

    def ==(other)
      other.respond_to?(:parent) && parent == other.parent &&
        other.respond_to?(:url) && url == other.url &&
        other.respond_to?(:path) && path == other.path
    end
  end
end
