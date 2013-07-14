# HTTPerf.rb

![Gem Version](https://badge.fury.io/rb/httperfrb.png) &nbsp; ![Build Status](https://travis-ci.org/jmervine/httperfrb.png?branch=master)

Simple Ruby interface for httperf.

## Installing 'httperf'

Requires [httperf](http://mervine.net/httperf), of course...

#### Mac

    :::shell
    sudo port install httperf

#### Debian / Ubuntu

    :::shell
    sudo apt-get install httperf

#### Redhat / CentOS

    :::shell
    sudo yum install httperf

#### My 'httperf'

See: [httperf-0.9.1 with individual connection times](http://mervine.net/httperf-0-9-1-with-individual-connection-times).

## Install

    :::shell
    gem install httperfrb

## Usage - HTTPerf

Some basic usage examples.

    :::ruby
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

### Teeing output

Added in 0.3.10.

> Adding the `tee` param will print httperf output while running the process.

    :::ruby
    require 'httperf'
    perf = HTTPerf.new( "server" => "host", "port" => 8080, "uri" => "/foo", "tee" => true )
    output = perf.run

### With HTTPerf::Parser

    :::ruby
    require 'httperf'
    perf = HTTPerf.new( "server" => "host", "port" => 8080, "uri" => "/foo" )
    puts perf.parse = true
    puts perf.run

    # or directly

    puts HTTPerf::Parser.parse( HTTPerf.new( "server" => "host", "port" => 8080, "uri" => "/foo" ).run )

## Useage - HTTPerf::Parser

    :::ruby
    require 'httperf/parser'

    # read result from a file, for example
    puts HTTPerf::Parser.parse( File.open("httperf.out", "r").read )

    # or verbose output
    puts HTTPerf::Parser.parse( File.open("httperf_verbose.out", "r").read, true )

#### From the command line:

Something I've been playing around with, it's more of hack really. But it works well for seralizing output to YAML or JSON:

##### To JSON file:

    :::shell
    httperf --num-conns=10 --verbose | ruby -e 'require "httperf/parser"; require "json"; puts HTTPerf::Parser.parse(ARGF.read).to_json' > httperf.json

##### To YAML file:

    :::shell
    httperf --num-conns=10 --verbose | ruby -e 'require "httperf/parser"; require "yaml"; puts HTTPerf::Parser.parse(ARGF.read).to_yaml' > httperf.yml

#### Parser Keys:

    :::ruby
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

#### Verbose Percentile Parser Keys:

    :connection_time_75_pct
    :connection_time_80_pct
    :connection_time_85_pct
    :connection_time_90_pct
    :connection_time_95_pct
    :connection_time_99_pct


#### Accepted Options:

- `"add-header"`
- `"burst-length"`
- `"client"`
- `"close-with-reset"`
- `"debug"`
- `"failure-status"`
- `"hog"`
- `"http-version"`
- `"max-connections"`
- `"max-piped-calls"`
- `"method"`
- `"no-host-hdr"`
- `"num-calls"`
- `"num-conns"`
- `"period"`
- `"port"`
- `"print-reply"`
- `"print-request"`
- `"rate"`
- `"recv-buffer"`
- `"retry-on-failure"`
- `"send-buffer"`
- `"server"`
- `"server-name"`
- `"session-cookies"`
- `"ssl"`
- `"ssl-ciphers"`
- `"ssl-no-reuse"`
- `"think-timeout"`
- `"timeout"`
- `"uri"`
- `"verbose"`
- `"version"`
- `"wlog"`
- `"wsess"`
- `"wsesslog"`
- `"wset"`
