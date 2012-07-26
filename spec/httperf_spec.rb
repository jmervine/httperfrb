require 'spec_helper'
describe HTTPerf do
  it "should init empty" do
    expect { HTTPerf.new }.to_not raise_error
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
