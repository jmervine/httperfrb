require 'simplecov'
SimpleCov.start do
    add_filter "/vendor/"
    add_filter "/coverage/"
    add_filter "/doc/"
    add_filter "/spec/"
    add_filter "version.rb"
end

require './lib/httperf'

$bad_params = { "bar" => "param" }
$good_params = { "server" => "localhost", "port" => 8080, "uri" => "/foo/bar" }

$results_raw = File.open("./spec/dummy_results.txt","r").read
$verbose_raw = File.open("./spec/dummy_verbose_results.txt","r").read

File.delete("httperf_test.png") if File.exists?("httperf_test.png")

