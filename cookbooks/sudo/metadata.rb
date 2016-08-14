name 'sudo'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache 2.0'
description 'Installs sudo and configures /etc/sudoers'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.11.0'

recipe 'sudo', 'Installs sudo and configures /etc/sudoers'

%w(redhat centos fedora ubuntu debian freebsd mac_os_x oracle scientific zlinux suse opensuse opensuseleap).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/sudo' if respond_to?(:source_url)
issues_url 'https://github.com/chef-cookbooks/sudo/issues' if respond_to?(:issues_url)

chef_version '>= 11' if respond_to?(:chef_version)
