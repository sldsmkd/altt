host_port = 8000
servers=[
  {
    :hostname => "web1",
    :ip => "192.168.179.10",
    :ssh_port => "10222",
    :role => "appserver"
  },
  {
    :hostname => "web2",
    :ip => "192.168.179.11",
    :ssh_port => "10223",
    :role => "appserver"
  },
  {
    :hostname => "lb",
    :ip => "192.168.179.12",
    :role => "loadbalancer",
    :ssh_port => "10224"
  }
]

webs = []
servers.each do |host|
  if host[:hostname] != "lb"
    webs << host[:ip]
  end
end

Vagrant.configure("2") do |config|
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
        chef.json = {
          "webs" => webs
        }
        chef.add_role "default"
        chef.add_role machine[:role]
        if machine[:role] == "loadbalancer" then
          node.vm.network "forwarded_port", guest: 80, host: host_port
        end
      end
      node.vm.provision "shell", path: "tests/systemcheck.py"
    end
  end
end