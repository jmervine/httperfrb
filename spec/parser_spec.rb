require 'spec_helper'
describe HTTPerf::Parser do
  it "should parse raw data" do
    HTTPerf::Parser.parse($results_raw).keys.count.should eq 50
  end
  {
    :command=>"httperf --client=0/1 --server=localhost --port=80 --uri=/ --send-buffer=4096 --recv-buffer=16384 --num-conns=1 --num-calls=1",
    :max_connect_burst_length=>"0",
		:total_connections=>"1",
		:total_requests=>"1",
		:total_replies=>"1",
		:total_test_duration=>"0.000",
		:connection_rate_per_sec=>"4524.6",
		:connection_rate_ms_conn=>"0.2",
		:connection_time_min=>"0.2",
		:connection_time_avg=>"0.2",
		:connection_time_max=>"0.2",
		:connection_time_median=>"0.5",
		:connection_time_stddev=>"0.0",
		:connection_time_connect=>"0.1",
		:connection_length=>"1.000",
		:request_rate_per_sec=>"4524.6",
		:request_rate_ms_request=>"0.2",
		:request_size=>"62.0",
		:reply_rate_min=>"0.0",
		:reply_rate_avg=>"0.0",
		:reply_rate_max=>"0.0",
		:reply_rate_stddev=>"0.0",
		:reply_rate_samples=>"0",
		:reply_time_response=>"0.1",
		:reply_time_transfer=>"0.0",
		:reply_size_header=>"154.0",
		:reply_size_content=>"168.0",
		:reply_size_footer=>"0.0",
		:reply_size_total=>"322.0",
		:reply_status_1xx=>"0",
		:reply_status_2xx=>"0",
		:reply_status_3xx=>"0",
		:reply_status_4xx=>"1",
		:reply_status_5xx=>"0",
		:cpu_time_user_sec=>"0.00",
		:cpu_time_system_sec=>"0.00",
		:cpu_time_user_pct=>"0.0",
		:cpu_time_system_pct=>"0.0",
		:cpu_time_total_pct=>"0.0",
		:net_io_kb_sec=>"1696.7",
		:net_io_bps=>"13.9*10^6",
		:errors_total=>"0",
		:errors_client_timeout=>"0",
		:errors_socket_timeout=>"0",
		:errors_conn_refused=>"0",
		:errors_conn_reset=>"0",
		:errors_fd_unavail=>"0",
		:errors_addr_unavail=>"0",
		:errors_ftab_full=>"0",
		:errors_other=>"0"}.each do |key,val|
      it "should parse field correctly -- #{key}" do
        HTTPerf::Parser.parse($results_raw)[key].should eq val
      end
  end
end
describe HTTPerf::Parser, "with verbose" do
  it "should parse raw data" do
    HTTPerf::Parser.parse($verbose_raw).keys.count.should eq 57
  end
  {
    :connection_time_75_pct=>"294.5",
    :connection_time_80_pct=>"328.5",
    :connection_time_85_pct=>"392.5",
    :connection_time_90_pct=>"418.5",
    :connection_time_95_pct=>"500.5",
    :connection_time_99_pct=>"688.5"
  }.each do |key,val|
    it "should parse verbose correctly -- #{key}" do
      HTTPerf::Parser.parse($verbose_raw)[key].should eq val
    end
  end
  it "should have :connection_times Array" do
    HTTPerf::Parser.parse($verbose_raw)[:connection_times].should be_an Array
    HTTPerf::Parser.parse($verbose_raw)[:connection_times].count.should eq 100
  end
end
