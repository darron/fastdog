require "rubygems"
require "fastly"

myfastly = Fastly.new(:user => "email@example.com", :password => "passw0rd", :api_key => "0x0x0xdea4beef")

myfastly.create_syslog(:service_id => "service-id-goes-here", :version => "version-number", :name => "website.example.com", :hostname => "syslog.example.com")