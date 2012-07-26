require 'spec_helper'
describe HTTPerf, "basic usage" do
  it "should init empty" do
    expect { HTTPerf.new }.to_not raise_error
  end
  it "should use path if set" do
    HTTPerf.new($good_params,"/usr/bin/httperf").pretend.should eq "/usr/bin/httperf --port=8080 --server=localhost --uri=/foo/bar \n"
  end
  it "should init with good params" do 
    expect { HTTPerf.new($good_params) }.to_not raise_error
  end
  it "should raise error with bad params" do
    expect { HTTPerf.new($bad_params) }.to raise_error
  end
  it "should build command correctly" do 
    HTTPerf.new($good_params).pretend.should eq "/usr/bin/httperf --port=8080 --server=localhost --uri=/foo/bar \n"
  end
end

describe HTTPerf, "#update_option" do
  it "should update an option" do
    perf = HTTPerf.new($good_params)
    perf.pretend.should eq "/usr/bin/httperf --port=8080 --server=localhost --uri=/foo/bar \n"
    perf.update_option("port", 9001)
    perf.pretend.should eq "/usr/bin/httperf --port=9001 --server=localhost --uri=/foo/bar \n"
  end
end

describe HTTPerf, "#run" do
  it "should update an option" do
    perf = HTTPerf.new
    perf.run.match /^httperf --client=0\/1 --server=localhost --port=80/
  end
end
