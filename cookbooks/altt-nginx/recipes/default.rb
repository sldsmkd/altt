#
# Cookbook Name:: altt_nginx
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

chef_gem "chef-rewind"
require 'chef/rewind'

dirs = ['/var/www', '/var/www/nginx-default', '/var/www/nginx-default/css']
dirs.each do |dir|
  directory '/var/www' do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

directory '/var/www/nginx-default' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory '/var/www/nginx-default/css' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/var/www/nginx-default/index.html' do
  source 'index.html.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/var/www/nginx-default/css/style.css' do
  source 'css/style.css.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

include_recipe 'nginx::default'

# rewind :template => "#{node['newrelic']['java-agent']['install_dir']}/newrelic.yml" do
#   source "agent/java/tmg-newrelic.yml.erb"
#   cookbook_name "tmg-newrelic"
# end
