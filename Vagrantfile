# -*- mode: ruby -*-
# vi: set ft=ruby :

servers=[
  {
    :hostname => "web1",
    :ip => "10.0.2.15",
    :ssh_port => "10222",
    :role => "appserver"
  },
  {
    :hostname => "web2",
    :ip => "10.0.2.16",
    :ssh_port => "10223",
    :role => "appserver"
  },
  {
    :hostname => "lb1",
    :ip => "10.0.2.18",
    :role => "loadbalancer",
    :ssh_port => "10224"
  }
]

Vagrant.configure("2") do |config|
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"
  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.vm.box = "puppetlabs/ubuntu-14.04-64-nocm"
      node.vm.network "private_network", ip: machine[:ip]
      node.vm.hostname = machine[:hostname]
      node.vm.network :forwarded_port, guest: 22, host: machine[:ssh_port], id: "ssh"
      node.vm.provision "chef_zero" do |chef|
        chef.version = "12.10.24"
        chef.cookbooks_path = "cookbooks"
        chef.data_bags_path = "data_bags"
        chef.nodes_path = "nodes"
        chef.roles_path = "roles"
        chef.add_role "default"
        chef.add_role machine[:role]
      end
      node.vm.provision "shell",
        inline: "curl --fail --location http://127.0.0.1/index.html; echo $?"
    end
  end
end