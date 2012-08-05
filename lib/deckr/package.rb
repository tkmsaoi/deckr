module Deckr
  class Package < Resource
    def resource(name)
      @resources ||= {}
      @resources[name.to_sym] ||= Resource.new(self, name)
    end

    %w(js css html).each do |ext|
      define_method ext.to_sym do
        resource("deck.#{File.basename(name)}.#{ext}")
      end
    end

    def exist?
      File.directory?(path)
    end

    def content
      ""
    end
  end
end
