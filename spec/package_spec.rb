require "spec_helper"

describe Deckr::Package do
  before do
    @package = Deckr::Package.new(fixtures, "foo/bar/baz")
  end

  describe "#resource" do
    subject { @package.resource("foo.txt") }
    it { should be_kind_of(Deckr::Resource) }
    its(:parent) { should == @package }
  end

  describe "#js" do
    subject { @package.js }
    it { should == @package.resource("deck.baz.js") }
  end

  describe "#css" do
    subject { @package.css }
    it { should == @package.resource("deck.baz.css") }
  end

  describe "#html" do
    subject { @package.html }
    it { should == @package.resource("deck.baz.html") }
  end

  describe "#exist?" do
    context "when directory exists" do
      subject { Deckr::Package.new(fixtures, "foo").exist? }
      it { should be_true }
    end

    context "when directory does't exist" do
      subject { Deckr::Package.new(fixtures, "bar").exist? }
      it { should be_false }
    end
  end

  describe "#content" do
    subject { @package.content }
    it { should be_empty }
  end
end
