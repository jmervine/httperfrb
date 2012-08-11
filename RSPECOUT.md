		
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
		
		HTTPerf basic usage
		  should init empty
		  should use path if set
		  should init with good params
		  should init with verbose
		  should init with parse
		  should raise error with bad params
		  should build command correctly
		
		HTTPerf#parse
		  should update parse flag
		
		HTTPerf#update_option
		  should update an option
		
		HTTPerf#run
		  should run httperf and wait for it to finish
		
		HTTPerf#run with verbose
		  should run httperf and wait for it to finish
		  should run httperf verobsely
		
		HTTPerf#run without parse
		  should run httperf and wait for it to finish
		
		HTTPerf#fork
		  should run httperf and fork the process unless a fork is running
		  should set output to #fork_out
		  should set errors to #fork_err
		
		Finished in 0.25218 seconds
		74 examples, 0 failures
		Coverage report generated for RSpec to /home/jmervine/Development/httperfrb/coverage. 158 / 159 LOC (99.37%) covered.
