require "spec_helper"

describe Deckr::Resource do
  before do
    @resource = Deckr::Resource.new(fixtures, "foo.txt")
  end

  describe ".new" do
    subject { @resource }
    its(:parent) { should == fixtures }
    its(:name) { should == "foo.txt" }
    its(:url) { should == File.join(fixtures.url, "foo.txt") }
    its(:path) { should == File.join(fixtures.path, "foo.txt") }
  end

  describe "#exist?" do
    context "when file exists" do
      subject { @resource.exist? }
      it { should be_true }
    end

    context "when file does't exist" do
      subject { Deckr::Resource.new(fixtures, "bar.txt").exist? }
      it { should be_false }
    end
  end

  describe "#content" do
    context "when file exists" do
      subject { @resource.content }
      it { should == File.read(@resource.path) }
    end

    context "when file does't exist" do
      subject { Deckr::Resource.new(fixtures, "bar.txt").content }
      it { should be_empty }
    end
  end

  describe "#==" do
    context "given object that does't respond to #parent, #url and #path" do
      subject { @resource == Object.new }
      it { should be_false }
    end

    context "given different resource" do
      subject do
        @resource ==
          double(:parent => @resource.parent, :url => "foo", :path => "bar")
      end
      it { should be_false }
    end

    context "given same resource" do 
      subject do
        @resource ==
          double(:parent => @resource.parent, :url => @resource.url, :path => @resource.path)
      end
      it { should be_true }
    end
  end
end
