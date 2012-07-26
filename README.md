HTTPERF.rb
==========

### [Documentation](http://rubyops.github.com/httperfrb/doc/) | [Coverage](http://rubyops.github.com/httperfrb/doc/) 

Simple Ruby interface for httperf.

Requires httperf, of course...

### Installing 'httperf'

#### Mac

    sudo port install httperf

#### Debian / Ubuntu

    sudo apt-get install httperf

#### Redhat / CentOS

    sudo yum install httperf

### Install

    gem install httperfrb

### Usage

    require 'httperf'
    perf = HTTPerf.new( "server" => "host", "port" => 8080, "uri" => "/foo" )
    perf.run

    perf.update_option("uri", "/foo/bar")
    perf.run

