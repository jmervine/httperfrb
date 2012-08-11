HTTPERF.rb
==========

### [Documentation](http://rubyops.github.com/httperfrb/doc/) | [Coverage](http://rubyops.github.com/httperfrb/coverage/) | [RSpec Out](https://github.com/rubyops/httperfrb/blob/master/RSPECOUT.md)

Simple Ruby interface for httperf.

#### Note

This currently needs a lot of work to be production ready. It's done more in a scripting style then a true solid application style. 


## Installing 'httperf'

Requires httperf, of course...

#### Mac

    sudo port install httperf

#### Debian / Ubuntu

    sudo apt-get install httperf

#### Redhat / CentOS

    sudo yum install httperf

## Install

    gem install httperfrb

## Usage - HTTPerf

Some basic usage examples.

    require 'httperf'
    perf = HTTPerf.new( "server" => "host", "port" => 8080, "uri" => "/foo" )
    puts perf.run

    perf.update_option("uri", "/foo/bar")
    thread = perf.fork
    while((thread.alive?))
      sleep 0.01
      print "#"
    end
    unless perf.fork_err.nil?
      puts perf.fork_out
    end

### With HTTPerf::Parser

    require 'httperf'
    perf = HTTPerf.new( "server" => "host", "port" => 8080, "uri" => "/foo" )
    puts perf.parser = true
    puts perf.run

    # or directly

    puts HTTPerf::Parser.parse( HTTPerf.new( "server" => "host", "port" => 8080, "uri" => "/foo" ).run )

## Useage - HTTPerf::Parser

    require 'httperf/parser' 
     
    # read result from a file, for example   
    puts HTTPerf.parse( File.open("httperf.out", "r").read )
    
    # or verbose output
    puts HTTPerf.parse( File.open("httperf_verbose.out", "r").read, true )
    
#### From the command line:

Something I've been playing around with, it's more of hack really. But it works well for seralizing output to YAML or JSON:

##### To JSON file:

    httperf --num-conns=10 --verbose | ruby -e 'require "httperf/parser"; require "json"; puts HTTPerf::Parser.parse(ARGF.read).to_json' > httperf.json

##### To YAML file:

    httperf --num-conns=10 --verbose | ruby -e 'require "httperf/parser"; require "yaml"; puts HTTPerf::Parser.parse(ARGF.read).to_yaml' > httperf.yml



##### Parser Keys: 

    :command
    :max_connect_burst_length
    :total_connections
    :total_requests
    :total_replies
    :total_test_duration
    :connection_rate_per_sec
    :connection_rate_ms_conn
    :connection_time_min
    :connection_time_avg
    :connection_time_max
    :connection_time_median
    :connection_time_stddev
    :connection_time_connect
    :connection_length
    :request_rate_per_sec
    :request_rate_ms_request
    :request_size
    :reply_rate_min
    :reply_rate_avg
    :reply_rate_max
    :reply_rate_stddev
    :reply_rate_samples
    :reply_time_response
    :reply_time_transfer
    :reply_size_header
    :reply_size_content
    :reply_size_footer
    :reply_size_total
    :reply_status_1xx
    :reply_status_2xx
    :reply_status_3xx
    :reply_status_4xx
    :reply_status_5xx
    :cpu_time_user_sec
    :cpu_time_system_sec
    :cpu_time_user_pct
    :cpu_time_system_pct
    :cpu_time_total_pct
    :net_io_kb_sec
    :net_io_bps
    :errors_total
    :errors_client_timeout
    :errors_socket_timeout
    :errors_conn_refused
    :errors_conn_reset
    :errors_fd_unavail
    :errors_addr_unavail
    :errors_ftab_full
    :errors_other
  

##### Addtional Verbose Parser Keys: 

    :connection_time_75_pct
    :connection_time_80_pct
    :connection_time_85_pct
    :connection_time_90_pct
    :connection_time_95_pct
    :connection_time_99_pct
