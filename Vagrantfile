Vagrant.configure("2") do |config|
  config.vm.box = "base"

  config.vm.define "server" do |server|
    server.vm.hostname = "server"

    server.vm.network "forwarded_port", guest: 4646, host: 4646
    server.vm.network "forwarded_port", guest: 5601, host: 5601
    server.vm.network "forwarded_port", guest: 8200, host: 8200
    server.vm.network "forwarded_port", guest: 8500, host: 8500
    server.vm.network "private_network", ip: "172.20.20.11"

    server.vm.provision "ansible_local", run: "always" do |ansible|
      ansible.playbook = "playbook.yml"
      ansible.provisioning_path = "/home/vagrant/packer-provisioner-ansible-local"
      ansible.tags = [
        "bootstrap",
        "server",
      ]
    end
  end

  config.vm.define "client" do |client|
    client.vm.hostname = "client"

    client.vm.network "forwarded_port", guest: 443, host: 5000
    client.vm.network "private_network", ip: "172.20.20.10"

    client.vm.provision "ansible" do |ansible|
      ansible.ask_become_pass = true
      ansible.playbook = "certificate.yml"
    end

    client.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "playbook.yml"
      ansible.provisioning_path = "/home/vagrant/packer-provisioner-ansible-local"
      ansible.tags = [
        "bootstrap",
        "client",
      ]
    end
  end

  config.vm.provider "virtualbox" do |virtualbox, override|
    override.vm.box_url = "file://boxes/packer_virtualbox-iso_virtualbox.box"
  end
end

# All custom Vagrant configuration is done below.
Vagrant.configure("2") do |config|
  config.vm.define "server" do |server|
  end

  config.vm.define "client" do |client|
  end
end
