require 'spec_helper'
describe HTTPerf::Grapher do
  describe "#new" do
    it "should initialize empty" do
      HTTPerf::Grapher.new.should be
    end
    it "should initialize with params" do 
      HTTPerf::Grapher.new(title: "Foobar").should be
    end
    it "should set params from passed Hash" do
      gh = HTTPerf::Grapher.new(title: "Foobar")
      gh.graph_settings.has_key?(:title).should be_true
    end
  end

  describe "#output_file" do
    it "should set output file" do
      gh = HTTPerf::Grapher.new
      gh.output_file = "foo.png"
      gh.output_file.should eq "foo.png"
    end
  end

  describe "#graph_settings" do
    it "should merge graph settings" do
      gh = HTTPerf::Grapher.new
      gh.graph_settings = { title: "Foobar" }
      gh.graph_settings[:title].should eq "Foobar"
    end
  end

  describe "#graph" do
    it "should create a graph" do
      parsed = HTTPerf::Parser.parse($verbose_raw, true, true)
      gh = HTTPerf::Grapher.new
      gh.output_file = "httperf_test.png"
      gh.graph(parsed).inspect.should match /^httperf_test\.png  800x600 DirectClass 16-bit/
      File.exists?("httperf_test.png").should be_true
    end
  end
end
