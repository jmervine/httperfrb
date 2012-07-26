class HTTPerf
  VERSION = "0.0.1"

  @options, @command = nil

  # initialize with (optional):
  # - options: see 'man httperf'
  # - path: path to httperf
  #   - e.g. /usr/bin/httperf
  def initialize options={}, path=nil
    options.each_key do |k|
      raise "#{k} is an invalid httperf param" unless params.keys.include?(k)
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

  # run httperf 
  def run 
    return %x{ #{@command} #{options} }
  end

  # print httperf command to be run
  # - for debugging and testing
  def pretend
    return %x{ echo "#{@command} #{options}" }
  end

  private
  def options
    opts = ""
    @options.each do |key,val|
      opts << "--#{key}=#{val} " unless val.nil?
    end
    opts
  end

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
      "period [d|u|e" => nil,
      "port" => nil,
      "print-reply [header|body" => nil,
      "print-request [header|body" => nil,
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

