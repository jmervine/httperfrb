require 'spec_helper'
describe HTTPerf, "basic usage" do
  it "should init empty" do
    expect { HTTPerf.new }.to_not raise_error
  end

  it "should use path if set" do
    begin
      HTTPerf.new($good_params,"/usr/bin/httperf").command.should eq "/usr/bin/httperf --port=8080 --server=localhost --uri=/foo/bar "
    rescue RuntimeError=>e
      e.to_s.should match(/\/usr\/bin\/httperf/)
    end
  end

  it "should init with good params" do
    expect { HTTPerf.new($good_params) }.to_not raise_error
  end

  it "should init with verbose" do
    expect { HTTPerf.new($good_params.merge("verbose" => true)) }.to_not raise_error
  end

  it "should init with tee" do
    expect { HTTPerf.new($good_params.merge("tee" => true)) }.to_not raise_error
    HTTPerf.new($good_params.merge("tee" => true)).instance_variable_get(:@tee).should be_true
  end

  it "should init with parse" do
    expect { HTTPerf.new($good_params.merge("parse" => true)) }.to_not raise_error
    p = HTTPerf.new($good_params.merge("parse" => true))
    p.parse.should be_true
    p.instance_variable_get(:@command).should_not match(/parse/)
  end

  it "should raise error with bad params" do
    expect { HTTPerf.new($bad_params) }.to raise_error
  end

  it "should build command correctly" do
    httperf = %x{ which httperf }.chomp
    HTTPerf.new($good_params).command.should eq "#{httperf} --hog --port=8080 --server=localhost --uri=/foo/bar "
  end

  context "initialize with command" do
    it "should accept command param" do
      expect { HTTPerf.new("command" => "httperf ") }.to_not raise_error
    end
    it "should accept command and parse" do
      expect { HTTPerf.new("command" => "httperf ", "parse" => true) }.to_not raise_error
    end
    it "should not accept anthing by command and parse" do
      expect { HTTPerf.new("command" => "httperf ", "parse" => true, "num-conns" => 1) }.to raise_error
    end
    it "should fail if command doesn't start with httperf" do
      expect { HTTPerf.new("command" => "foo") }.to raise_error
    end
    it "should accept valid command line options" do
      expect { HTTPerf.new("command" => "httperf --num-conns=2", "parse" => true) }.to_not raise_error
      expect { HTTPerf.new("command" => "httperf --num-conns 2", "parse" => true) }.to_not raise_error
      expect { HTTPerf.new("command" => "httperf --verbose", "parse" => true) }.to_not raise_error
      expect { HTTPerf.new("command" => "httperf --num-conns=2 --hog", "parse" => true) }.to_not raise_error
    end
    it "should set httperf exe correctly" do
      HTTPerf.new("command" => "httperf --num-conns=2", "parse" => true).command.should include "\/httperf "

      # The error below means that the httperf command has be successful set
      # and things are moving along to validate it.
      expect { HTTPerf.new("command" => "/foo/bar/httperf --num-conns=2", "parse" => true).command.should start_with "/foo/bar/httperf " }.to raise_error(/\/foo\/bar\/httperf not found/)
    end

    it "should set cli options correctly" do
      # test a few possible options
      [ "--num-conns=2 --server=foobar",
        "--num-conns 2 --server foobar",
        "--server=foobar --rate 10",
        "--server fooar --rate=10",
        "--num-conns=2 --hog --verbose",
        "--num-conns 2" ].each do |param|
        expect { HTTPerf.new("command" => "httperf #{param}") }.to_not raise_error
      end

      # Check to ensure has the right param, not just didn't
      # fail.
      HTTPerf.new("command" => "httperf --server=foobar").command.should include "--server=foobar"
      HTTPerf.new("command" => "httperf --server=foobar --rate 2").command.should include "--rate=2"
      HTTPerf.new("command" => "httperf --server=foobar --verbose").command.should include "--verbose"
      HTTPerf.new("command" => "httperf --server=foobar --verbose --hog").command.should include "--hog"
    end
  end
end

describe HTTPerf, "#parse" do
  it "should update parse flag" do
    perf = HTTPerf.new($good_params)
    perf.parse.should be_false
    perf.parse = true
    perf.parse.should be_true
  end
end

describe HTTPerf, "#update_option" do
  it "should update an option" do
    httperf = %x{ which httperf }.chomp
    perf = HTTPerf.new($good_params)
    perf.command.should eq "#{httperf} --hog --port=8080 --server=localhost --uri=/foo/bar "
    perf.update_option("port", 9001)
    perf.command.should eq "#{httperf} --hog --port=9001 --server=localhost --uri=/foo/bar "
  end
end

describe HTTPerf, "#run" do
  it "should run httperf and wait for it to finish" do
    perf = HTTPerf.new
    perf.parse = true
    perf.run.keys.count.should eq 50
  end
end

describe HTTPerf, "#run with verbose" do
  before(:all) do
    @run = HTTPerf.new("verbose" => true).run
  end
  it "should run httperf and wait for it to finish" do
    @run.match(/^httperf --client=0\/1 --server=localhost --port=80/)
  end
  it "should run httperf verobsely" do
    @run.match(/^httperf .+ --verbose/)
    @run.match(/^Connection lifetime = /)
  end
end

describe HTTPerf, "#run with tee" do
  before(:all) do
    @outio = StringIO.new
    @old_stdout = $stdout
    $stdout = @outio
  end

  after(:all) do
    $stdout = @old_stdout
  end

  it "should not tee output to STDOUT" do
    out_size_before = @outio.length
    perf = HTTPerf.new
    perf.run
    @outio.length.should eq out_size_before
  end

  it "should tee output to STDOUT" do
    out_size_before = @outio.length
    perf = HTTPerf.new("tee" => true)
    perf.run
    @outio.length.should be > out_size_before
  end
end

describe HTTPerf, "#run without parse" do
  it "should run httperf and wait for it to finish" do
    perf = HTTPerf.new
    perf.run.match(/^httperf --client=0\/1 --server=localhost --port=80/)
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
    @perf.fork_out.should match(/^httperf/)
  end
  it "should set errors to #fork_err" do
    @perf.fork_err.should be_nil
  end
  it "should parse" do
    @perf.parse = true
    @thread = @perf.fork
    while(( @thread.alive? ))
      sleep 0.1
    end
    @thread.alive?.should be_false
    require 'pp'
    pp @perf.fork_out
  end
end

