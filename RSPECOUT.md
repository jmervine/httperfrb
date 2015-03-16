		
		HTTPerf basic usage
		  should init empty
		  should use path if set
		  should init with good params
		  should init with verbose
		  should init with tee
		  should init with parse
		  should raise error with bad params
		  should build command correctly
		  initialize with command
		    should accept command param
		    should accept command and parse
		    should not accept anthing by command and parse
		    should fail if command doesn't start with httperf
		    should accept valid command line options
		    should set httperf exe correctly
		    should set cli options correctly
		
		HTTPerf#parse
		  should update parse flag
		
		HTTPerf#update_option
		  should update an option
		
		HTTPerf#run
		  should run httperf and wait for it to finish
		  should run with query params
		
		HTTPerf#run with verbose
		  should run httperf and wait for it to finish
		  should run httperf verobsely
		
		HTTPerf#run with tee
		  should not tee output to STDOUT
		  should tee output to STDOUT
		
		HTTPerf#run without parse
		  should run httperf and wait for it to finish
		
		HTTPerf#fork
		  should run httperf and fork the process unless a fork is running
		  should set output to #fork_out
		  should set errors to #fork_err
		{:command=>
		  "httperf --client=0/1 --server=localhost --port=80 --uri=/ --send-buffer=4096 --recv-buffer=16384 --num-conns=1 --num-calls=1",
		 :max_connect_burst_length=>"0",
		 :total_connections=>"1",
		 :total_requests=>"1",
		 :total_replies=>"1",
		 :total_test_duration=>"0.002",
		 :connection_rate_per_sec=>"531.1",
		 :connection_rate_ms_conn=>"1.9",
		 :connection_time_min=>"2.1",
		 :connection_time_avg=>"2.1",
		 :connection_time_max=>"2.1",
		 :connection_time_median=>"2.5",
		 :connection_time_stddev=>"0.0",
		 :connection_time_connect=>"0.2",
		 :connection_length=>"1.000",
		 :request_rate_per_sec=>"531.1",
		 :request_rate_ms_request=>"1.9",
		 :request_size=>"62.0",
		 :reply_rate_min=>"0.0",
		 :reply_rate_avg=>"0.0",
		 :reply_rate_max=>"0.0",
		 :reply_rate_stddev=>"0.0",
		 :reply_rate_samples=>"0",
		 :reply_time_response=>"1.6",
		 :reply_time_transfer=>"0.2",
		 :reply_size_header=>"287.0",
		 :reply_size_content=>"54915.0",
		 :reply_size_footer=>"0.0",
		 :reply_size_total=>"55202.0",
		 :reply_status_1xx=>"0",
		 :reply_status_2xx=>"1",
		 :reply_status_3xx=>"0",
		 :reply_status_4xx=>"0",
		 :reply_status_5xx=>"0",
		 :cpu_time_user_sec=>"0.00",
		 :cpu_time_system_sec=>"0.00",
		 :cpu_time_user_pct=>"0.0",
		 :cpu_time_system_pct=>"53.1",
		 :cpu_time_total_pct=>"53.1",
		 :net_io_kb_sec=>"28660.6",
		 :net_io_bps=>"234.8*10^6",
		 :errors_total=>"0",
		 :errors_client_timeout=>"0",
		 :errors_socket_timeout=>"0",
		 :errors_conn_refused=>"0",
		 :errors_conn_reset=>"0",
		 :errors_fd_unavail=>"0",
		 :errors_addr_unavail=>"0",
		 :errors_ftab_full=>"0",
		 :errors_other=>"0"}
		  should parse
		
		HTTPerf::Parser
		  should parse raw data
		  should parse field correctly -- command
		  should parse field correctly -- max_connect_burst_length
		  should parse field correctly -- total_connections
		  should parse field correctly -- total_requests
		  should parse field correctly -- total_replies
		  should parse field correctly -- total_test_duration
		  should parse field correctly -- connection_rate_per_sec
		  should parse field correctly -- connection_rate_ms_conn
		  should parse field correctly -- connection_time_min
		  should parse field correctly -- connection_time_avg
		  should parse field correctly -- connection_time_max
		  should parse field correctly -- connection_time_median
		  should parse field correctly -- connection_time_stddev
		  should parse field correctly -- connection_time_connect
		  should parse field correctly -- connection_length
		  should parse field correctly -- request_rate_per_sec
		  should parse field correctly -- request_rate_ms_request
		  should parse field correctly -- request_size
		  should parse field correctly -- reply_rate_min
		  should parse field correctly -- reply_rate_avg
		  should parse field correctly -- reply_rate_max
		  should parse field correctly -- reply_rate_stddev
		  should parse field correctly -- reply_rate_samples
		  should parse field correctly -- reply_time_response
		  should parse field correctly -- reply_time_transfer
		  should parse field correctly -- reply_size_header
		  should parse field correctly -- reply_size_content
		  should parse field correctly -- reply_size_footer
		  should parse field correctly -- reply_size_total
		  should parse field correctly -- reply_status_1xx
		  should parse field correctly -- reply_status_2xx
		  should parse field correctly -- reply_status_3xx
		  should parse field correctly -- reply_status_4xx
		  should parse field correctly -- reply_status_5xx
		  should parse field correctly -- cpu_time_user_sec
		  should parse field correctly -- cpu_time_system_sec
		  should parse field correctly -- cpu_time_user_pct
		  should parse field correctly -- cpu_time_system_pct
		  should parse field correctly -- cpu_time_total_pct
		  should parse field correctly -- net_io_kb_sec
		  should parse field correctly -- net_io_bps
		  should parse field correctly -- errors_total
		  should parse field correctly -- errors_client_timeout
		  should parse field correctly -- errors_socket_timeout
		  should parse field correctly -- errors_conn_refused
		  should parse field correctly -- errors_conn_reset
		  should parse field correctly -- errors_fd_unavail
		  should parse field correctly -- errors_addr_unavail
		  should parse field correctly -- errors_ftab_full
		  should parse field correctly -- errors_other
		
		HTTPerf::Parser with verbose
		  should parse raw data
		  should parse verbose correctly -- connection_time_75_pct
		  should parse verbose correctly -- connection_time_80_pct
		  should parse verbose correctly -- connection_time_85_pct
		  should parse verbose correctly -- connection_time_90_pct
		  should parse verbose correctly -- connection_time_95_pct
		  should parse verbose correctly -- connection_time_99_pct
		  should have :connection_times Array
		
		Finished in 1.13 seconds
		87 examples, 0 failures
		Coverage report generated for RSpec to /home/jmervine/Development/httperfrb/coverage. 1419 / 3096 LOC (45.83%) covered.
