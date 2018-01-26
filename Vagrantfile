Vagrant.configure("2") do |config|
  config.vm.box = "base"
  config.vm.box_url = "file://builds/packer_virtualbox-iso_virtualbox.box"

  config.vm.define "server" do |server|
    server.vm.hostname = "server"

    server.vm.network "forwarded_port", guest: 4646, host: 4646
    server.vm.network "forwarded_port", guest: 8200, host: 8200
    server.vm.network "forwarded_port", guest: 8500, host: 8500
    server.vm.network "private_network", ip: "172.20.20.11"

    server.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "playbook.yml"
      ansible.provisioning_path = "/home/vagrant/packer-provisioner-ansible-local"
      ansible.tags = ["bootstrap", "server"]
    end
  end

  config.vm.define "client" do |client|
    client.vm.hostname = "client"

    client.vm.network "private_network", ip: "172.20.20.10"

    client.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "playbook.yml"
      ansible.provisioning_path = "/home/vagrant/packer-provisioner-ansible-local"
      ansible.tags = ["bootstrap", "client"]
    end
  end
end
