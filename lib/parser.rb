class Parser
  def self.parse raw
    matches = raw.match(/.+Total: connections (\d+) requests (\d+) replies (\d+) test-duration (\d+).+Connection rate: (\d+) conn\/s \((\d+) ms\/conn, .+Connection time \[ms\]: min (\d+) avg (\d+) max (\d+) median (\d+) stddev (\d+).+Connection time \[ms\]: connect (\d+).+Connection length \[replies\/conn\]: (\d+).+Request rate: (\d+) req\/s \((\d+) ms\/req\).+Request size \[B\]: (\d+).+Reply rate \[replies\/s\]: min (\d+) avg (\d+) max (\d+) stddev (\d+) \((\d+) samples\).+Reply time \[ms\]: response (\d+) transfer (\d+).+Reply size \[B\]: header (\d+) content (\d+) footer (\d+) \(total (\d+)\).+Reply status: 1xx=(\d+) 2xx=(\d+) 3xx=(\d+) 4xx=(\d+) 5xx=(\d+).+CPU time \[s\]: user (\d+) system (\d+) \(user (\d+)% system (\d+)% total (\d+)%\).+Net I\/O: (\d+) KB\/s.+Errors: total (\d+) client-timo (\d+) socket-timo (\d+) connrefused (\d+) connreset (\d+).+Errors: fd-unavail (\d+) addrunavail (\d+) ftab-full (\d+) other (\d+).+/m)
    return matches
  end
end

