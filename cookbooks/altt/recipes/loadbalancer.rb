#
# Cookbook Name:: altt
# Recipe:: loadbalancer
#
chef_gem 'chef-rewind'
require 'chef/rewind'

rewind :template => "/etc/nginx/sites-available/default" do
  source "sites-available-loadbalancer.erb"
  cookbook_name "altt"
  notifies :reload, "service[nginx]", :delayed
end