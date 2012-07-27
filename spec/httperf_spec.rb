require 'spec_helper'
describe HTTPerf, "basic usage" do
  it "should init empty" do
    expect { HTTPerf.new }.to_not raise_error
  end
  it "should use path if set" do
    HTTPerf.new($good_params,"/usr/bin/httperf").command.should eq "/usr/bin/httperf --port=8080 --server=localhost --uri=/foo/bar "
  end
  it "should init with good params" do 
    expect { HTTPerf.new($good_params) }.to_not raise_error
  end
  it "should raise error with bad params" do
    expect { HTTPerf.new($bad_params) }.to raise_error
  end
  it "should build command correctly" do 
    HTTPerf.new($good_params).command.should eq "/usr/bin/httperf --port=8080 --server=localhost --uri=/foo/bar "
  end
end

describe HTTPerf, "#update_option" do
  it "should update an option" do
    perf = HTTPerf.new($good_params)
    perf.command.should eq "/usr/bin/httperf --port=8080 --server=localhost --uri=/foo/bar "
    perf.update_option("port", 9001)
    perf.command.should eq "/usr/bin/httperf --port=9001 --server=localhost --uri=/foo/bar "
  end
end

describe HTTPerf, "#run" do
  it "should run httperf and wait for it to finish" do
    perf = HTTPerf.new
    perf.run.match /^httperf --client=0\/1 --server=localhost --port=80/
  end
end

describe HTTPerf, "#fork" do
  before(:all) do
    @perf = HTTPerf.new
    @thread = nil
  end
  it "should run httperf and fork the process unless a fork is running" do
    expect { @thread = @perf.fork }.to_not raise_error
    expect { @perf.fork }.to raise_error
    @thread.alive?.should be_true
    while(( @thread.alive? ))
      sleep 0.1
    end
    @thread.alive?.should be_false
  end
  it "should set output to #fork_out" do
    @perf.fork_out.should match /^httperf/
  end
  it "should set errors to #fork_err" do
    @perf.fork_err.should be_nil
  end
end

