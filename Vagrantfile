Vagrant.configure("2") do |config|
  config.vm.box = "base"

  config.vm.define "server" do |server|
    server.vm.hostname = "server"

    # Port forwarding rules for Nomad, Kibana, Vault, and Consul,
    # respectively.
    server.vm.network "forwarded_port", guest: 4646, host: 4646
    server.vm.network "forwarded_port", guest: 5601, host: 5601
    server.vm.network "forwarded_port", guest: 8200, host: 8200
    server.vm.network "forwarded_port", guest: 8500, host: 8500

    server.vm.network "private_network", ip: "172.20.20.11"

    server.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioning/deployment.yml"
      ansible.tags = "server"
    end

    # Always perform the Vault unseal process IF the Vault is sealed.
    server.vm.provision "ansible", run: "always" do |ansible|
      ansible.playbook = "provisioning/unseal.yml"
    end
  end

  config.vm.define "client" do |client|
    client.vm.hostname = "client"

    client.vm.network "forwarded_port", guest: 443, host: 5000
    client.vm.network "private_network", ip: "172.20.20.10"

    client.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioning/deployment.yml"
      ansible.tags = "client"
    end
  end

  config.vm.provider "libvirt" do |libvirt, override|
    libvirt.connect_via_ssh = true
    libvirt.host = ENV["LIBVIRT_HOST"]
    libvirt.username = ENV["LIBVIRT_USERNAME"]

    # Remote virtual machine resourcing and configuration.
    libvirt.cpus = 4
    libvirt.memory = 4096
    # Assigning a domain a random hostname prevents naming conflicts.
    libvirt.random_hostname = true

    override.vm.box_url = "file://boxes/packer_qemu_libvirt.box"
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
