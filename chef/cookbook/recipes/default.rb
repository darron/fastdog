#
# Cookbook Name:: fastdog
# Recipe:: default
#
# Copyright 2012, Darron Froese
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package "libcurl4-openssl-dev"

gem_package "fastly"
gem_package "dogstatsd-ruby"
gem_package "statsd"
gem_package "dogapi"
gem_package "eventmachine"
gem_package "eventmachine-tail"

execute "firewall: default allow syslog" do
  command "/usr/sbin/ufw allow 514"
  not_if "/usr/sbin/ufw status verbose | grep '514'"
  action :run
end

template "/home/username/fastdog.rb" do
  source "tail.erb"
  owner "username"
  group "username"
  mode "0755"
end

service "rsyslog" do
  service_name "rsyslog"
  restart_command "/usr/sbin/service rsyslog restart"
  action :start
end

template "/etc/rsyslog.conf" do
  source "rsyslog.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "rsyslog")
end