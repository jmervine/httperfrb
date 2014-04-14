# @author Joshua Mervine <joshua@mervine.net>
$:.unshift File.dirname(__FILE__)
require 'httperf/parser'
require 'httperf/version'

autoload :PTY,   'pty'
autoload :Open4, 'open4'

begin
  require 'httperf/grapher'
rescue LoadError
end

class HTTPerf

  # @return [Boolean] parse flag
  attr_accessor :parse, :tee

  # availbe instance methods
  @fork_out, @fork_err = ''
  @fork_thr, @options, @command = nil
  @tee = false

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
    self.tee   = options.delete("tee")
    options    = parse_command_option(options) if options.has_key?("command")

    validate_options(options)
    set_command_from_path(path) unless @command

    @options   = params.merge(options)
  end

  # update a given option
  def update_option(opt, val)
    @options[opt] = val
  end

  # run httperf and wait for it to finish
  #  return errors if any, otherwise return
  #  results
  def run
    out = ""

    begin
      PTY.spawn(command) do |stdout, stdin, pid|
        begin
          stdout.each do |line|
            out << line.strip+"\n"
            print line if @tee
          end
        rescue Errno::EIO
          #Errno:EIO error probably just means that the process has finished giving output
        end
        Process.wait(pid)
      end
    rescue PTY::ChildExited
      # The child process has exited.
    end

    if $?.exitstatus == 0
      return Parser.parse(out) if @parse
      return out
    else
      raise "httperf exited with status #{$?.exitstatus}\n\nhttperf output:\n--------------\n#{out}"
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
      return Parser.parse(@fork_out)
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

  def parse_command_option options
    command = options.delete("command")
    raise "Option command must not be passed with other options" unless options.empty?

    raise "Invalid httperf command" unless !!(command.match(/([a-z\/]*)httperf /))

    command.gsub!("--hog", "--hog=true")
    command.gsub!("--verbose", "--verbose=true")

    cli_options(command).each { |clio| options.merge!(split_cli_option(clio)) }

    options
  end

  def cli_options command
    opts = command.split(" --")
    set_command_from_path(opts.delete_at(0))
    opts
  end

  def set_command_from_path(path)
    if path && path.start_with?("/")
      path = path.chomp
      @command = (path =~ /httperf$/ ? path : File.join(path, "httperf"))
      raise "#{@command} not found" unless %x{ test -x "#{@command}" && echo "true" }.chomp == "true"
    else
      set_command_without_path
    end
  end

  def set_command_without_path
    @command = %x{ which httperf }.chomp
    raise "httperf not found" unless @command =~ /httperf/
  end

  def split_cli_option(clio)
    kvp = clio.split("=")
    kvp = clio.split(" ") unless kvp.size == 2
    raise "Error parsing command params" unless kvp.size == 2
    return { kvp.first => kvp.last }
  end

  def validate_options options
    options.each_key do |k|
      raise "'#{k}' is an invalid httperf param" unless params.keys.include?(k)
    end
  end

end

