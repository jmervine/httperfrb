# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'httperf'
 
Gem::Specification.new do |s|
  s.name        = "httperfrb"
  s.version     = HTTPerf::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Joshua Mervine"]
  s.email       = ["joshua@mervine.net"]
  s.homepage    = "http://github.com/rubyops/httperfrb"
  s.summary     = "HTTPerf via Ruby"
  s.description = "Simple interface for calling httperf via ruby."
 
  s.required_rubygems_version = ">= 1.3.6"
 
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "yard"

  s.add_dependency "open4"
  s.add_dependency "rmagick", "~>2.13.1"
  s.add_dependency "gruff", "~>0.3.6"

  s.files        = Dir.glob("lib/**/*") + %w(README.md HISTORY.md Gemfile)
  s.require_path = 'lib'
end

