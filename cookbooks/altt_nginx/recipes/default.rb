#
# Cookbook Name:: altt_nginx
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

chef_gem "chef-rewind"
require 'chef/rewind'

include_recipe 'nginx::default'

# rewind :template => "#{node['newrelic']['java-agent']['install_dir']}/newrelic.yml" do
#   source "agent/java/tmg-newrelic.yml.erb"
#   cookbook_name "tmg-newrelic"
# end
