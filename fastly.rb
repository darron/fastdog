require "rubygems"
require "fastly"

fastly = Fastly.new(:user => "email@example.com", :password => "passw0rd", :api_key => "0x0x0xdea4beef")

# FYI - you can't target your currently running Fastly version - you need to target a new one - then deploy that.
fastly.create_syslog(:service_id => "service-id-goes-here", :version => "version-number", :name => "website.example.com", :hostname => "syslog.example.com")