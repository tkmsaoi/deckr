require "spec_helper"

describe Deckr::Deck do
  before do
    @deck = Deckr::Deck.new("/deck", deck_path)
  end

  describe ".new" do
    subject { @deck }
    its(:parent) { should be_nil }
    its(:url) { should == "/deck" }
    its(:path) { should == deck_path }
    its(:name) { should == @deck.path }
    its(:extensions) { should be_empty }
    its(:style) { should be_nil }
    its(:transition) { should be_nil }
  end

  describe "#resource" do
    subject { @deck.resource("foo") }
    it { should be_kind_of(Deckr::Resource) }
    its(:parent) { should == @deck }
  end

  describe "#package" do
    subject { @deck.package("foo") }
    it { should be_kind_of(Deckr::Package) }
    its(:parent) { should == @deck }
  end

  describe "#core" do
    subject { @deck.core }
    it { should == @deck.package("core") }
  end

  describe "#style" do
    context "given a style name" do
      subject { @deck.style "foo" }
      it { should == @deck.resource("themes/style/foo.css") }
    end

    context "given nil" do
      subject { @deck.style nil }
      it { should == nil }
    end

    context "given false" do
      subject { @deck.style false }
      it { should == false }
    end

    context "given no arguments" do
      it "returns a specified style" do
        @deck.style "foo"
        @deck.style.should == @deck.resource("themes/style/foo.css")
      end
    end
  end

  describe "#transition" do
    context "given a transition name" do
      subject { @deck.transition "foo" }
      it { should == @deck.resource("themes/transition/foo.css") }
    end

    context "given nil" do
      subject { @deck.transition nil }
      it { should == nil }
    end

    context "given false" do
      subject { @deck.transition false }
      it { should == false }
    end

    context "given no arguments" do
      it "returns a specified transition" do
        @deck.transition "foo"
        @deck.transition.should == @deck.resource("themes/transition/foo.css")
      end
    end
  end

  describe "#enable" do
    before { @deck.enable "foo", "bar", "foo" }
    subject { @deck.extensions }
    it { should have(2).items }
    its([0]) { should == @deck.package("extensions/foo") }
    its([1]) { should == @deck.package("extensions/bar") }
  end

  describe "#disable" do
    before do
      @deck.enable "foo", "bar", "baz"
      @deck.disable "foo", "baz"
    end
    subject { @deck.extensions }
    it { should have(1).items }
    its([0]) { should == @deck.package("extensions/bar") }
  end

  describe "#exist?" do
    context "when directory exists" do
      subject { @deck.exist? }
      it { should be_true }
    end

    context "when directory doesn't exist" do
      subject { Deckr::Package.new(fixtures, "bar").exist? }
      it { should be_false }
    end
  end

  describe "#content" do
    subject { @deck.content }
    it { should be_empty }
  end
end
