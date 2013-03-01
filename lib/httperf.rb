# @author Joshua Mervine <joshua@mervine.net>
$:.unshift File.dirname(__FILE__)
require 'httperf/parser'
require 'httperf/version'

autoload :Open3, 'open3'
autoload :Open4, 'open4'

begin
  require 'httperf/grapher'
rescue LoadError
end

class HTTPerf

  # @return [Boolean] parse flag
  attr_accessor :parse

  # availbe instance methods
  @fork_out, @fork_err = ''
  @fork_thr, @options, @command = nil

  # initialize with (optional):
  # - options: see below for options
  #   - see 'man httfperf' for details
  # - path: path to httperf
  #   - e.g. /usr/bin/httperf
  #
  # available options:
  #   -  add-header
  #   -  burst-length
  #   -  client
  #   -  close-with-reset
  #   -  debug
  #   -  failure-status
  #   -  hog
  #   -  http-version
  #   -  max-connections
  #   -  max-piped-calls
  #   -  method
  #   -  no-host-hdr
  #   -  num-calls
  #   -  num-conns
  #   -  period
  #   -  port
  #   -  print-reply
  #   -  print-request
  #   -  rate
  #   -  recv-buffer
  #   -  retry-on-failure
  #   -  send-buffer
  #   -  server
  #   -  server-name
  #   -  session-cookies
  #   -  ssl
  #   -  ssl-ciphers
  #   -  ssl-no-reuse
  #   -  think-timeout
  #   -  timeout
  #   -  uri
  #   -  verbose
  #   -  version
  #   -  wlog
  #   -  wsess
  #   -  wsesslog
  #   -  wset
  def initialize options={}, path=nil
    self.parse = options.delete("parse")
    if options.has_key?("command")
      command = options.delete("command")
      raise "Option command must not be passed with other options" unless options.empty?

      valid_command = !!(command.match(/([a-z\/]*)httperf /))
      raise "Invalid httperf command" unless valid_command

      command.gsub!("--hog", "--hog=true")
      command.gsub!("--verbose", "--verbose=true")

      cli_options = command.split(" --")
      path = cli_options.delete_at(0)
      path = nil unless path.start_with?("/")

      cli_options.each do |clio|
        kvp = clio.split("=")
        kvp = clio.split(" ") unless kvp.size == 2
        raise "Error parsing command params" unless kvp.size == 2
        options[kvp.first] = kvp.last
      end
    end

    options.each_key do |k|
      raise "'#{k}' is an invalid httperf param" unless params.keys.include?(k)
    end
    @options = params.merge(options)
    if path.nil?
      @command = %x{ which httperf }.chomp
      raise "httperf not found" unless @command =~ /httperf/
    else
      path = path.chomp
      @command = (path =~ /httperf$/ ? path : File.join(path, "httperf"))
      raise "#{@command} not found" unless %x{ test -x "#{@command}" && echo "true" }.chomp == "true"
    end
  end

  # update a given option
  def update_option(opt, val)
    @options[opt] = val
  end

  # run httperf and wait for it to finish
  #  return errors if any, otherwise return
  #  results
  def run
    status, out, err = nil
    Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
      pid = wait_thr.pid
      out = stdout.readlines
      err = stderr.readlines
      status = wait_thr.value
    end
    if status == 0
      if @parse
        return Parser.parse(out.join)
      else
        return out.join
      end
    else
      return err.join
    end
  end

  # run httperf, fork and return thread
  def fork
    raise "httperf fork currently running" if @fork_thr && @fork_thr.alive?
    @fork_out, @fork_err = ''
    @fork_thr = Open4::bg command, :stdin => nil, :stdout => @fork_out, :stderr => @fork_err
    @fork_thr
  end

  # return results of last fork
  def fork_out
    if @parse
      return Parse.parse(@fork_out, self.parse)
    else
      return @fork_out
    end
  end

  # return errors from last fork
  def fork_err
    @fork_err
  end

  # print httperf command to be run
  # - for debugging and testing
  def command
    return "#{@command} #{options}"
  end

  private
  # build commandline options string
  def options
    opts = ""
    @options.each do |key,val|
      opts << "--#{key}=#{val} " unless val.nil?
    end
    opts.gsub!("--hog=true", "--hog")
    opts.gsub!("--hog=false", "")
    opts.gsub!("--verbose=true", "--verbose")
    opts.gsub!("--verbose=false", "")
    opts
  end

  # define httperf available options
  def params
    {
      "add-header" => nil,
      "burst-length" => nil,
      "client" => nil,
      "close-with-reset" => nil,
      "debug" => nil,
      "failure-status" => nil,
      "hog" => nil,
      "http-version" => nil,
      "max-connections" => nil,
      "max-piped-calls" => nil,
      "method" => nil,
      "no-host-hdr" => nil,
      "num-calls" => nil,
      "num-conns" => nil,
      "period" => nil,
      "port" => nil,
      "print-reply" => nil,
      "print-request" => nil,
      "rate" => nil,
      "recv-buffer" => nil,
      "retry-on-failure" => nil,
      "send-buffer" => nil,
      "server" => nil,
      "server-name" => nil,
      "session-cookies" => nil,
      "ssl" => nil,
      "ssl-ciphers" => nil,
      "ssl-no-reuse" => nil,
      "think-timeout" => nil,
      "timeout" => nil,
      "uri" => nil,
      "verbose" => nil,
      "version" => nil,
      "wlog" => nil,
      "wsess" => nil,
      "wsesslog" => nil,
      "wset" => nil
    }
  end

end

