#
# Cookbook Name:: altt
# Recipe:: hello
#
chef_gem 'chef-rewind'
require 'chef/rewind'

include_recipe 'supervisor'
include_recipe 'nginx'

easy_install_package 'Uwsgi' do
  action :install
end

directory '/var/log/hello' do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end

supervisor_service "hello" do
  action :enable
  autostart true
  autorestart true
  user "www-data"
  stopsignal "INT"
  stdout_logfile "/var/log/hello/out.log"
  stderr_logfile "/var/log/hello/err.log"
  command "/usr/bin/uwsgi --wsgi-file /vagrant/site/hello/hello.py --ini=/vagrant/site/hello/hello.ini"
end

rewind :template => "/etc/nginx/sites-available/default" do
  source "sites-available-hello.erb"
  cookbook_name "altt"
  notifies :reload, "service[nginx]", :delayed
end